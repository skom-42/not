class CustomException implements Exception {
  final String errorMessage;

  CustomException({
    required this.errorMessage,
  });
}
