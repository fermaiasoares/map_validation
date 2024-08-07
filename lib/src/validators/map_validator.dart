import 'package:map_validation/map_validation.dart';

class MapValidator extends Validator<Map<String, dynamic>> {
  final Map<String, Validator> schema;

  MapValidator(
    this.schema, {
    required super.fieldName,
    super.locale,
  }) {
    schema.forEach((key, validator) {
      validator.locale = locale;
    });
  }

  @override
  bool validate(Map<String, dynamic>? value, [Map<String, dynamic>? data]) {
    clearErrors();

    if (value == null) {
      addError('O mapa não pode ser nulo.');

      return false;
    }

    bool isValid = true;

    for (final key in schema.keys) {
      final validator = schema[key];
      final fieldValue = value[key];

      if (!validator!.validate(fieldValue, value)) {
        isValid = false;

        errors.putIfAbsent(fieldName, () => {});
        errors[fieldName][key] = validator.errors[validator.fieldName];
      }
    }

    return isValid;
  }
}
