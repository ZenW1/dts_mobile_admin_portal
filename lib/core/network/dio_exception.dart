import 'package:dio/dio.dart' show DioException, DioExceptionType;

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = 'Request was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection';
        break;
      default:
        message = 'An unknown error occurred';
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    return switch (statusCode) {
      400 => 'Bad request',
      401 => 'Unauthorized',
      403 => 'Forbidden',
      404 => 'Not found',
      422 => 'Duplicate email',
      500 => 'Internal server error',
      502 => 'Bad gateway',
      _ => 'An unknown error occurred'
    };
  }

  @override
  String toString() => message;
}
