import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

typedef ValidResponse<T> = ({bool valid, String? reason, T? data});

abstract base class RequestRepository {
  // late ApiHelpers apiHelpers = ApiHelpers();
  // late PqApiClient client = Get.find<PqApiClient>();

  ValidResponse<T> isValidResponse<T>(Response response) {
    final statusCode = response.statusCode ?? 400;
    if (statusCode >= 200 && statusCode < 300) {
      return (valid: true, reason: null, data: null);
    }

    // if (statusCode == HttpStatus.unauthorized && Get.currentRoute != LoginModule.path) {
    //   Get.offAllNamed(LoginModule.path);
    //   return (valid: false, reason: '401', data: null);
    // }

    return (
    valid: false,
    data: null,
    reason: null,//ApiExceptionHandler.handleError(statusCode, response.data),
    );
  }
}
