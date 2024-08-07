import 'package:map_validation/src/validator.dart';

class BooleanValidator<T> extends Validator<T> {
  bool? isRequired;
  String? requiredMessage;
  String? invalidMessage;

  BooleanValidator({
    this.isRequired,
    this.requiredMessage,
    this.invalidMessage,
    super.locale,
    required super.fieldName,
  });

  @override
  bool validate(T? value, [Map<String, dynamic>? data]) {
    clearErrors();

    if (isRequired == true && value == null) {
      addError('field_required', customMessage: requiredMessage);
      return false;
    }

    if (value != null && value is! bool) {
      addError('invalid_boolean', customMessage: invalidMessage);
      return false;
    }

    return true;
  }
}
