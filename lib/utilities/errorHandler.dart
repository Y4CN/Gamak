class ErrorHandler implements Exception {
  int? code;
  String? message;

  ErrorHandler(this.code, this.message);
}
