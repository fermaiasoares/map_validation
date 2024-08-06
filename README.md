# Map Validation Package

O pacote Map Validation fornece uma maneira flexível e extensível de validar dados de um `Map` em Dart, inspirado no Joi.js. Permite criar esquemas de validação com suporte a tipos variados, mensagens de erro personalizadas e internacionalização.

## Instalação

Para adicionar o pacote ao seu projeto Dart, inclua a dependência no arquivo `pubspec.yaml`:

```yaml
dependencies:
  map_validation: ^1.0.0
```

## Uso
Definindo um Esquema de Validação
Crie um esquema de validação utilizando os validadores disponíveis. Aqui está um exemplo básico:

```dart
import 'package:map_validation/src/validators/boolean_validator.dart';
import 'package:map_validation/src/validators/date_validator.dart';
import 'package:map_validation/src/validators/number_validator.dart';
import 'package:map_validation/src/validation_schema.dart';
import 'package:map_validation/src/exceptions/validation_exception.dart';

void main() {
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

  final validData = {
    'is_active': true,
    'start_date': DateTime(2023, 6, 15),
    'total_amount': 150,
    'discount_code': 25,
  };

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
    if (e is ValidationException) {
      print('Erros com dados válidos: ${e.errors}');
    }
  }

  // Validando dados inválidos
  try {
    schema.validate(invalidData);
  } catch (e) {
    if (e is ValidationException) {
      print('Erros com dados inválidos: ${e.errors}');
    }
  }
}
```

## Validadores Disponíveis
`BooleanValidator` Valida valores booleanos. Permite definir se o campo é obrigatório e mensagens de erro personalizadas.

```dart
import 'package:map_validation/src/validators/boolean_validator.dart';

final validator = BooleanValidator(
  isRequired: true,
  requiredMessage: 'O campo é obrigatório.',
  invalidMessage: 'Deve ser um booleano.',
);

```

---
`DateValidator` Valida datas com suporte para valores mínimos e máximos, e mensagens de erro personalizadas.

```dart
import 'package:map_validation/src/validators/date_validator.dart';

final validator = DateValidator(
  minDate: DateTime(2023, 1, 1),
  maxDate: DateTime(2024, 12, 31),
  isRequired: true,
  requiredMessage: 'Data é obrigatória.',
  minDateMessage: 'Data deve ser após {minDate}.',
  maxDateMessage: 'Data deve ser antes de {maxDate}.',
);
```

---
`NumberValidator` Valida números com suporte para valores mínimos e máximos e se deve ser inteiro. Inclui mensagens de erro personalizadas.

```dart
import 'package:map_validation/src/validators/number_validator.dart';

final validator = NumberValidator(
  min: 10,
  max: 1000,
  isInteger: true,
  isRequired: true,
  requiredMessage: 'Número é obrigatório.',
  minMessage: 'Número deve ser pelo menos {min}.',
  maxMessage: 'Número não deve exceder {max}.',
);

```
---
`StringValidator` Valida strings com suporte para comprimento mínimo/máximo e padrões regex. Inclui mensagens de erro personalizadas.

```dart
import 'package:map_validation/src/validators/string_validator.dart';

final validator = StringValidator(
  minLength: 3,
  maxLength: 30,
  pattern: RegExp(r'^[a-zA-Z0-9_]+$'),
  isRequired: true,
  requiredMessage: 'O nome é obrigatório.',
  minLengthMessage: 'O nome deve ter pelo menos {minLength} caracteres.',
  maxLengthMessage: 'O nome deve ter no máximo {maxLength} caracteres.',
  patternMessage: 'O nome deve conter apenas letras, números e sublinhados.',
);

```

---
`ConditionalValidator` Valida um campo com base em uma condição que depende de outro campo. Permite definir uma função condicional e mensagens de erro personalizadas.
```dart
import 'package:map_validation/src/validators/conditional_validator.dart';

final validator = ConditionalValidator<String, String>(
  condition: (value, dependentValue, data) => value == dependentValue,
  dependentValue: 'password',
  errorMessageKey: 'repeat_password_mismatch',
  customMessage: 'A confirmação da senha deve corresponder à senha.',
);
```
---
`MultiValidator` Valida um campo que pode receber mais de um tipo de valor exemplo campo númerico exemplo '123' ou 123.
```dart
import 'src/validators/multi_validator.dart';
import 'src/validators/string_validator.dart';
import 'src/validators/number_validator.dart';

void main() {
  final multiValidator = MultiValidator([
    StringValidator(minLength: 3),
    NumberValidator(min: 10, max: 100)
  ]);

  final value = '123'; // Pode ser uma string ou número

  if (multiValidator.validate(value)) {
    print('O valor é válido.');
  } else {
    print('Erros de validação: ${multiValidator.errors}');
  }
}

```

## Tratamento de Erros
Os erros de validação são lançados como exceções ValidationException, contendo um mapa de erros para cada campo.

```dart
import 'package:map_validation/src/exceptions/validation_exception.dart';

try {
  // Validar dados
} catch (e) {
  if (e is ValidationException) {
    print('Erros: ${e.errors}');
  }
}
```

## Licença

Este pacote é licenciado sob uma Licença de Uso Restrito. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

### Direitos Autorais

© 2024 [Fernando Maia](https://github.com/fermaiasoares). Todos os direitos reservados.

### Termos de Uso

A permissão é concedida apenas para uso pessoal ou não comercial conforme autorizado. Qualquer uso comercial, redistribuição ou modificação do software sem permissão prévia é estritamente proibido. Para obter uma licença comercial ou permissão para outros usos, entre em contato com Fernando Maia em [seu email].

