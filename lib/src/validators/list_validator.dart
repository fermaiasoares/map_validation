import 'package:map_validation/map_validation.dart';

class ListValidator<T> extends Validator<List<T>> {
  final Validator<T> itemValidator;
  final bool isRequired;
  String? requiredMessage;

  ListValidator(
    this.itemValidator, {
    this.isRequired = false,
    this.requiredMessage,
    required super.fieldName,
    super.locale,
  }) {
    itemValidator.locale = locale;
  }

  @override
  bool validate(List<T>? value, [Map<String, dynamic>? data]) {
    clearErrors();

    if (value == null && isRequired == true) {
      addError('field_required', customMessage: requiredMessage);
      return false;
    }

    bool isValid = true;

    for (var i = 0; i < (value?.length ?? 0); i++) {
      if (!itemValidator.validate(value![i], data)) {
        isValid = false;

        errors.putIfAbsent(fieldName, () => {});
        errors[fieldName][i] = itemValidator.errors.values.last;
      }
    }

    return isValid;
  }
}
