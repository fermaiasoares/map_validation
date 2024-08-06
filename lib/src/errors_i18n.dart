sealed class ErrorsI18n {
  static const Map<String, Map<String, String>> messages = {
    'en': {
      'field_required': 'Field is required.',
      'invalid_boolean': 'Value must be a boolean.',
      'invalid_date': 'Invalid date format.',
      'min_value': 'Value must be at least {min}.',
      'max_value': 'Value must not exceed {max}.',
      'min_length': 'String must be at least {min} characters long.',
      'max_length': 'String must not exceed {max} characters long.',
      'pattern_mismatch': 'String does not match the required pattern.',
      'invalid_email': 'Invalid email address.',
      'condition_failed': 'Condition failed.',
      'min_date': 'Date must be after {minDate}.',
      'max_date': 'Date must be before {maxDate}.',
    },
    'pt_BR': {
      'field_required': 'O campo é obrigatório.',
      'invalid_boolean': 'O valor deve ser um booleano.',
      'invalid_date': 'Formato de data inválido.',
      'min_value': 'O valor deve ser pelo menos {min}.',
      'max_value': 'O valor não deve exceder {max}.',
      'min_length': 'A string deve ter pelo menos {min} caracteres.',
      'max_length': 'A string não deve exceder {max} caracteres.',
      'pattern_mismatch': 'A string não corresponde ao padrão requerido.',
      'invalid_email': 'Endereço de e-mail inválido.',
      'condition_failed': 'Condição falhou.',
      'min_date': 'A data deve ser posterior a {minDate}.',
      'max_date': 'A data deve ser anterior a {maxDate}.',
    },
  };
}
