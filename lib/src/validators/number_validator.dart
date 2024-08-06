import 'package:map_validation/src/validator.dart';

class NumberValidator extends Validator<num> {
  num? min;
  num? max;
  bool? isInteger;
  bool? isRequired;

  String? requiredMessage;
  String? minMessage;
  String? maxMessage;
  String? integerMessage;

  NumberValidator({
    this.min,
    this.max,
    this.isInteger,
    this.isRequired,
    this.requiredMessage,
    this.minMessage,
    this.maxMessage,
    this.integerMessage,
    super.locale,
  });

  @override
  bool validate(num? value, [Map<String, dynamic>? data]) {
    clearErrors();

    if (isRequired == true && value == null) {
      addError('field_required', customMessage: requiredMessage);
      return false;
    }

    if (value != null) {
      if (min != null && value < min!) {
        addError('min_value', params: {'min': min!}, customMessage: minMessage);
      }
      if (max != null && value > max!) {
        addError('max_value', params: {'max': max!}, customMessage: maxMessage);
      }
      if (isInteger == true && value is! int) {
        addError('must_be_integer', customMessage: integerMessage);
      }
    }

    return errors.isEmpty;
  }
}
