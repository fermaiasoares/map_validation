import 'package:map_validation/map_validation.dart';

void main() {
  // Definindo o esquema de validação
  final schema = ValidatorSchema({
    'is_active': BooleanValidator(
      isRequired: true,
      requiredMessage: 'O campo ativo é obrigatório.',
      invalidMessage: 'O valor deve ser um booleano.',
    ),
    'start_date': DateValidator(
      minDate: DateTime(2023, 1, 1),
      maxDate: DateTime(2024, 12, 31),
      isRequired: true,
      requiredMessage: 'A data de início é obrigatória.',
      minDateMessage: 'A data deve ser após {minDate}.',
      maxDateMessage: 'A data deve ser antes de {maxDate}.',
    ),
    'total_amount': NumberValidator(
      min: 10,
      max: 1000,
      isInteger: true,
      isRequired: true,
      requiredMessage: 'O valor total é obrigatório.',
      minMessage: 'O valor deve ser pelo menos {min}.',
      maxMessage: 'O valor não deve exceder {max}.',
    ),
    'discount_code': NumberValidator(
      isRequired: false, // Opcional
      isInteger: false, // Pode ser decimal
      min: 0,
      max: 100,
      minMessage: 'O desconto deve ser pelo menos {min}%',
      maxMessage: 'O desconto não deve exceder {max}%',
    ),
  }, locale: 'pt_BR');

  // Dados válidos
  final validData = {
    'is_active': true,
    'start_date': DateTime(2023, 6, 15),
    'total_amount': 150,
    'discount_code': 25,
  };

  // Dados inválidos
  final invalidData = {
    'is_active': 'yes', // Tipo inválido
    'start_date': DateTime(2025, 1, 1), // Fora do intervalo
    'total_amount': 5, // Abaixo do mínimo
    'discount_code': 150, // Acima do máximo
  };

  // Validando dados válidos
  try {
    schema.validate(validData);
    print('Dados válidos: Nenhum erro');
  } catch (e) {
    if (e is ValidatorException) {
      print('Erros com dados válidos: ${e.errors}');
    }
  }

  // Validando dados inválidos
  try {
    schema.validate(invalidData);
  } catch (e) {
    if (e is ValidatorException) {
      print('Erros com dados inválidos: ${e.errors}');
    }
  }
}
