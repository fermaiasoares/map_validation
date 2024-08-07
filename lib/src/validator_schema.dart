import 'package:map_validation/map_validation.dart';

class ValidatorSchema {
  final Map<String, Validator> validators;
  final String locale;

  ValidatorSchema(
    this.validators, {
    this.locale = 'en',
  }) {
    validators.forEach((key, validator) {
      validator.locale = locale;
    });
  }

  void validate(Map<String, dynamic> data) {
    Map<String, dynamic> errors = {};

    validators.forEach((key, validator) {
      if (!validator.validate(data[key], data)) {
        errors[key] = validator.errors[validator.fieldName]!;
      }
    });

    if (errors.isNotEmpty) {
      throw ValidatorException(errors);
    }
  }
}
