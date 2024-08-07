import 'package:map_validation/map_validation.dart';

/// Valida um valor com base em uma lista de validadores.
class MultiValidator<T> extends Validator<T> {
  final List<Validator<T>> validators;

  MultiValidator(
    this.validators, {
    required super.fieldName,
    super.locale,
  });

  @override
  bool validate(T? value, [Map<String, dynamic>? data]) {
    errors.clear();
    bool isValid = false;

    for (var validator in validators) {
      if (validator.validate(value)) {
        isValid = true;
        break;
      }
    }

    if (!isValid) {
      addError('O valor deve atender a pelo menos um dos validadores.');
    }

    return isValid;
  }
}
