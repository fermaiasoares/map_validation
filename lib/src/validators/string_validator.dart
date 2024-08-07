import 'package:map_validation/src/validator.dart';

class StringValidator extends Validator<String> {
  int? minLength;
  int? maxLength;
  RegExp? pattern;
  bool? isEmail;
  bool? isRequired;

  String? requiredMessage;
  String? minMessage;
  String? maxMessage;
  String? integerMessage;
  String? patternMessage;
  String? invalidEmailMessage;

  StringValidator({
    this.minLength,
    this.maxLength,
    this.pattern,
    this.isEmail,
    this.isRequired,
    this.requiredMessage,
    this.minMessage,
    this.maxMessage,
    this.integerMessage,
    this.patternMessage,
    this.invalidEmailMessage,
    super.locale,
    required super.fieldName,
  });

  @override
  bool validate(String? value, [Map<String, dynamic>? data]) {
    clearErrors();

    if (isRequired == true && value == null) {
      addError('field_required');
      return false;
    }

    if (value != null) {
      if (minLength != null && value.length < minLength!) {
        addError('min_length',
            params: {'min': minLength!}, customMessage: minMessage);
      }
      if (maxLength != null && value.length > maxLength!) {
        addError('max_length',
            params: {'max': maxLength!}, customMessage: maxMessage);
      }
      if (pattern != null && !pattern!.hasMatch(value)) {
        addError('pattern_mismatch', customMessage: patternMessage);
      }
      if (isEmail == true && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        addError('invalid_email', customMessage: invalidEmailMessage);
      }
    }

    return errors.isEmpty;
  }
}
