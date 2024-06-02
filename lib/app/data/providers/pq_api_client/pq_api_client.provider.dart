import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart' hide Response;
import 'package:phishing_quest/app/data/providers/pq_api_client/pq_api_client.interface.dart';
import 'package:phishing_quest/app/data/util/api/api_exception_handler.dart';
import 'package:phishing_quest/app/data/util/api/api_helpers.dart';
import 'package:phishing_quest/app/data/util/helpers/index.dart';

typedef Header = Map<String, dynamic>;
typedef Request = Future<Response> Function();

/// `GtApiClient` serves as a HTTP client.
/// It has methods for processing GET, POST, PUT HTTP requests.
/// It utilizes the Dio HTTP client under the hood for sending these requests.
/// Errors encountered during requests are caught and logging is done using the Debugger class.
/// API related helpers are accessed from the ApiHelpers class.
class GtApiClient extends GetxService implements IPqApiClient {
  late final Dio _dio;
  late final Helpers _helpers;
  late final ApiHelpers _apiHelpers;

  /// Constructs a `GtApiClient` instance.
  ///
  /// - `apiHelpers` - Instance of ApiHelpers.
  /// - `dio` - Dio HTTP client instance.
  GtApiClient({
    ApiHelpers? apiHelpers,
    Helpers? helpers,
    Dio? dio,
  }) {
    _apiHelpers = apiHelpers ?? ApiHelpers();
    _helpers = helpers ?? Helpers();
    _dio = dio ?? Dio()
      ..interceptors.add(_apiHelpers.getInterceptor());

    if (!_helpers.isLocalMode()) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
          () => HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    }
  }

  /// Sends a GET request to the given `url` with optional `headers`.
  ///
  /// On exception, returns an error Response.
  @override
  Future<Response> get(String url, {Header headers = const {}}) {
    final options = _apiHelpers.generateOptions()..headers?.addAll(headers);

    return _sendRequest(() => _dio.get(url, options: options));
  }

  /// Sends a POST request to the given `url` with `body` and optional `headers`.
  ///
  /// On exception, returns an error Response.
  // @override
  // Future<Response> post(String url, dynamic body, {Header headers = const {}}) {
  //   final options = _apiHelpers.generateOptions()..headers?.addAll(headers);
  //   final data = body is String ? _apiHelpers.cleanupPayload(body) : body;
  //
  //   return _sendRequest(() => _dio.post(url, data: data, options: options));
  // }

  @override
  Future<Response> post(String url, dynamic body, {Map<String, dynamic> headers = const {}}) {
    final options = _apiHelpers.generateOptions();
    options.headers?.addAll(headers);
    // final data = body is String ? _apiHelpers.cleanupPayload(body) : body;

    return _sendRequest(() => _dio.post(url, data: body, options: options));
  }

  @override
  Future<Response> postParams(String url, Map<String, dynamic> queryParams, {Map<String, dynamic> headers = const {}}) {
    final options = _apiHelpers.generateOptions();
    options.headers?.addAll(headers);

    final response = _dio.post(url, options: options, queryParameters: queryParams);
    return response;
  }

  /// Sends a PUT request to the given `url` with `body` and optional `headers`.
  ///
  /// On exception, returns an error Response.
  @override
  Future<Response> put(String url, dynamic body, {Header headers = const {}}) {
    final options = _apiHelpers.generateOptions()..headers?.addAll(headers);
    // final data = body is String ? _apiHelpers.cleanupPayload(body) : body;

    var response = _dio.put(url, data: body, options: options);

    return response; //_sendRequest(() => _dio.put(url, data: data, options: options));
  }

  /// Private method that sends an HTTP request and handles exceptions.
  ///
  /// On exception, logs the error and returns an error Response.
  Future<Response> _sendRequest(Request request) async {
    try {
      return await request();
    } catch (err) {
      if (err is! DioException) {
        rethrow;
      }

      return Response(
        requestOptions: err.requestOptions,
        statusCode: err.response?.statusCode ?? 400,
        data: ApiExceptionHandler.fromDioError(err).message,
      );
    }
  }
}
