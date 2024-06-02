import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

/// [ApiExceptionHandler] implements [Exception] and is designed to handle
/// different types of [DioException] that might occur during API calls. It
/// provides user-friendly error messages based on the type of [DioException].
class ApiExceptionHandler implements Exception {
  /// Constructor expects a [DioException] and provides corresponding user-friendly error message.
  ApiExceptionHandler.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'A requisição para a API foi cancelada';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Timeout de conexão com o servidor';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Timeout no recebimento de conexão com o servidor';
        break;
      case DioExceptionType.badResponse:
        message = handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = 'Timeout no envio de conexão com o servidor';
        break;
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          message = 'Sem conexão com a internet';
          break;
        }
        message = 'Ocorreu um erro inesperado';
        break;
      default:
        message = 'Erro desconhecido do servidor';
        break;
    }
  }

  /// Variable to hold error message string.
  late String message;

  /// Override [toString] to return the error message when this exception is thrown.
  @override
  String toString() => message;

  /// Helper method to handle HTTP error status codes.
  /// It takes [statusCode] and [error] as parameters and returns an appropriate error message.
  static String handleError(int? statusCode, dynamic error, {String currentRoute = ''}) {
    if (currentRoute.isEmpty) {
      currentRoute = Get.currentRoute;
    }

    if (statusCode == HttpStatus.unauthorized && (currentRoute.isEmpty || currentRoute == '/login')) {
      return 'Usuário ou senha inválidos';
    }

    switch (statusCode) {
      case HttpStatus.badRequest:
        return 'Requisição enviada de forma incorreta';
      case HttpStatus.unauthorized:
        return 'Token de autenticação inválido ou faltando';
      case HttpStatus.forbidden:
        return 'Acesso não autorizado, verifique suas permissões e tente novamente';
      case HttpStatus.notFound:
        return error.toString();
      case HttpStatus.internalServerError:
        return 'Erro interno do servidor';
      case HttpStatus.badGateway:
        return 'Requisição inválida para o gateway';
      default:
        return 'Erro desconhecido, favor contatar o suporte técnico, código do erro: $statusCode';
    }
  }
}
