import 'package:map_validation/src/validator.dart';

typedef Condition<T, K> = bool Function(
    T? value, K? dependentValue, Map<String, dynamic>? data);

class ConditionalValidator<T, K> extends Validator<T> {
  final Condition<T, K> condition;
  final String dependentField;
  final String errorMessageKey;
  final String? customMessage;

  ConditionalValidator({
    required this.condition,
    required this.dependentField,
    this.errorMessageKey = 'condition_failed',
    this.customMessage,
    super.locale,
    required super.fieldName,
  });

  @override
  bool validate(T? value, [Map<String, dynamic>? data]) {
    clearErrors();

    final dependentValue = data?[dependentField];

    if (!condition(value, dependentValue, data!)) {
      addError(errorMessageKey, customMessage: customMessage);
      return false;
    }

    return true;
  }
}
