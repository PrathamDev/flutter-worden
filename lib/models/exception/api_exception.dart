class ApiException implements Exception {
  final ApiExceptionCode code;
  final String message;

  ApiException({
    required this.code,
    required this.message,
  });
}

enum ApiExceptionCode {
  wordNotFound,
}
