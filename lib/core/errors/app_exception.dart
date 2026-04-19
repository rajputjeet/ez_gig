class AppException implements Exception {
  final String message;
  final int? statusCode;
  const AppException({required this.message, this.statusCode});
  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException()
      : super(message: 'No internet connection. Please check your network.');
}

class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException()
      : super(message: 'Invalid credentials. Please try again.', statusCode: 401);
}

class TimeoutException extends AppException {
  const TimeoutException()
      : super(message: 'Request timed out. Please try again.');
}
