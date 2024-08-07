import 'package:map_validation/src/validator.dart';

class DateValidator extends Validator<DateTime> {
  DateTime? minDate;
  DateTime? maxDate;
  bool? isRequired;
  String? requiredMessage;
  String? minDateMessage;
  String? maxDateMessage;

  DateValidator({
    this.minDate,
    this.maxDate,
    this.isRequired,
    this.requiredMessage,
    this.minDateMessage,
    this.maxDateMessage,
    super.locale,
    required super.fieldName,
  });

  @override
  bool validate(DateTime? value, [Map<String, dynamic>? data]) {
    clearErrors();

    if (isRequired == true && value == null) {
      addError('field_required', customMessage: requiredMessage);
      return false;
    }

    if (value != null) {
      if (minDate != null && value.isBefore(minDate!)) {
        addError('min_date',
            params: {'minDate': minDate!}, customMessage: minDateMessage);
      }
      if (maxDate != null && value.isAfter(maxDate!)) {
        addError('max_date',
            params: {'maxDate': maxDate!}, customMessage: maxDateMessage);
      }
    }

    return errors.isEmpty;
  }
}
