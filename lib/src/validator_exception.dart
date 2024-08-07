class ValidatorException implements Exception {
  final Map<String, dynamic> errors;

  ValidatorException(this.errors);

  @override
  String toString() {
    return 'ValidatorException: $errors';
  }
}
