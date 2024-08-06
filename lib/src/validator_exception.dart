class ValidatorException implements Exception {
  final Map<String, List<String>> errors;

  ValidatorException(this.errors);

  @override
  String toString() {
    return 'ValidatorException: $errors';
  }
}
