class InputInvalidException implements Exception {
  final String message;

  InputInvalidException({required this.message});

  @override
  String toString() {
    return message;
  }
}
