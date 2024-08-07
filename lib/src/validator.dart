import 'package:map_validation/src/errors_i18n.dart';
import 'package:map_validation/src/validator_exception.dart';

abstract class Validator<T> {
  Map<String, dynamic> errors = {};
  String locale;
  String fieldName;

  Validator({
    this.locale = 'en',
    required this.fieldName,
  });

  bool validate(T? value, [Map<String, dynamic>? data]);

  void addError(
    String messageKey, {
    Map<String, dynamic>? params,
    String? customMessage,
  }) {
    late String message;

    if (customMessage != null) {
      message = customMessage;
    } else {
      message = ErrorsI18n.messages[locale]![messageKey]!;
    }

    if (params != null) {
      params.forEach((key, value) {
        message = message.replaceAll('{$key}', value.toString());
      });
    }

    errors.putIfAbsent(fieldName, () => []);
    errors[fieldName]!.add(message);
  }

  void clearErrors() {
    errors.clear();
  }

  void throwIfInvalid(T? value, [Map<String, dynamic>? data]) {
    if (!validate(value, data)) {
      throw ValidatorException(errors);
    }
  }
}
