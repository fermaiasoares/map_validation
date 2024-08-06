import 'package:map_validation/src/validator.dart';
import 'package:map_validation/src/validator_exception.dart';

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
    Map<String, List<String>> errors = {};

    validators.forEach((key, validator) {
      try {
        validator.throwIfInvalid(data[key], data);
      } catch (e) {
        if (e is ValidatorException) {
          errors[key] = validator.errors;
        }
      }
    });

    if (errors.isNotEmpty) {
      throw ValidatorException(errors);
    }
  }
}
