import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:phishing_quest/app/data/constants/environments.dart';
import 'package:phishing_quest/app/data/enumerators/endpoints.enum.dart';
import 'package:phishing_quest/app/data/enumerators/storage_keys.enum.dart';
import 'package:phishing_quest/app/data/storage/memory_storage.dart';
import 'package:phishing_quest/app/data/util/api/api_exception_handler.dart';
import 'package:phishing_quest/app/data/util/debugger.dart';
// import 'package:phishing_quest/app/data/util/extensions/string_extension.dart';
import 'package:phishing_quest/app/data/util/helpers/index.dart';

/// A helper class to facilitate the interaction with APIs.
class ApiHelpers {
  static const String _JSON_TYPE = 'application/json';

  late final Helpers _helpers;
  late final Debugger _debugger;
  late final MemoryStore _authStore;

  ApiHelpers({Helpers? helpers, Debugger? debugger, MemoryStore? authStore}) {
    _helpers = helpers ?? Helpers();
    _debugger = debugger ?? Debugger(helpers: _helpers);
    _authStore = authStore ?? MemoryStore(StorageKeys.USER_TOKEN);
  }

  /// Returns the HTTP status code of the [response].
  /// If the response's status code is `null`,
  /// defaults to `HttpStatus.internalServerError (500)`.
  int _getResponseCode(Response? response) => response?.statusCode ?? HttpStatus.internalServerError;

  /// Decodes the response body.
  /// If the response body is not a JSON object,
  /// then returns the response body as a string.
  ///
  /// Params: [response] - the server's response which can be a valid json object or a string.
  dynamic _getDecodedBody(dynamic response) {
    final data = (response is DioException ? response.response : response)?.data.toString() ?? '';

    try {
      return jsonDecode(data);
    } catch (_) {
      return data;
    }
  }

  /// Logs the details of an intercepted request/response.
  /// The [requestResponse] may be either a [Response] or a request.
  /// Logs details like method, path, headers, status code, data sent, and body (if any) of the request/response
  void logInterceptedRequest(dynamic requestResponse) {
    final Response? response = requestResponse is DioException ? requestResponse.response : requestResponse;

    final method = response?.requestOptions.method ?? '';
    final path = response?.requestOptions.path ?? '';

    final bodyMap = {
      'code': _getResponseCode(response),
      'dataSent': response?.requestOptions.data,
      ...(requestResponse is DioException
          ? {'error': ApiExceptionHandler.fromDioError(requestResponse).toString()}
          : {}),
      'body': _getDecodedBody(requestResponse)
    };

    final responseType = requestResponse is DioException ? 'Error' : 'Response';
    _debugger.log(
      classPointer: '$responseType - $method',
      method: path,
      message: bodyMap.toString(),
    );
  }

  /// Returns an [InterceptorsWrapper] which includes two callbacks, `onError` and `onResponse`.
  ///
  /// - The `onError` callback: Takes a [DioException] as a parameter.
  ///   Logs the intercepted request using `logInterceptedRequest` and continues with the original error.
  /// - The `onResponse` callback: Takes a [Response] as a parameter.
  ///   Logs the intercepted request using `logInterceptedRequest` and continues with the original response.
  InterceptorsWrapper getInterceptor() {
    return InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {
        logInterceptedRequest(error);
        handler.next(error);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        logInterceptedRequest(response);
        handler.next(response);
      },
    );
  }

  /// Generates and returns [Options] for Dio requests.
  /// Headers are set to accept and send 'application/json'.
  /// Send and receive timeouts are also set based on the current environment mode.
  Options generateOptions() {
    final authToken = _authStore.read<String>();
    final timeout = _helpers.isLocalMode() ? LOCAL_ENV.endpoint.timeout : PRODUCTION_ENV.endpoint.timeout;

    return Options(
      headers: {
        Headers.acceptHeader: _JSON_TYPE,
        Headers.contentTypeHeader: _JSON_TYPE,
        ...(authToken != null ? {'Authorization': 'Bearer $authToken'} : {}),
        ...(_helpers.isLocalMode() ? {'ngrok-skip-browser-warning': 1} : {}),
      },
      sendTimeout: Duration(seconds: timeout),
      receiveTimeout: Duration(seconds: timeout),
    );
  }

  // /// Takes a payload in form of a string and applies several replacements to clean up the payload
  // /// Params: [payload] - the payload to be cleaned up
  // /// Returns cleaned up payload
  // String cleanupPayload(String payload) {
  //   // payload.replaceMany
  //   return payload.replaceMany([
  //     (look: '\\', replacement: ''),
  //     (look: '"[', replacement: '['),
  //     (look: ']"', replacement: ']'),
  //   ]);
  // }

  /// Builds up a full URL appending the [url] to the main API endpoint.
  /// Params:
  ///  - [url] - the specific endpoint to which the request is made
  ///  - [endpoint] - the base part of the API url, which can be different based on the environment.
  String buildUrl({required String url, Endpoints endpoint = Endpoints.PROJETO}) {
    final endpointEnv = _helpers.isLocalMode() ? LOCAL_ENV.endpoint : PRODUCTION_ENV.endpoint;

    switch (endpoint) {
      case Endpoints.PROJETO:
        return '${endpointEnv.projeto}$url';
    }
  }


  /// Returns the [CacheLifespan] based on the environment mode.
  int getCacheLifespan() => _helpers.isLocalMode() ? LOCAL_ENV.cacheLifespan : PRODUCTION_ENV.cacheLifespan;
}
