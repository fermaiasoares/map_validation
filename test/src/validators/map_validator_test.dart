import 'package:map_validation/map_validation.dart';
import 'package:test/test.dart';

void main() {
  test('Testar um objeto complexo', () {
    var schema = ValidatorSchema(locale: 'pt_BR', {
      'nome': StringValidator(
        fieldName: 'nome',
        minLength: 3,
        maxLength: 50,
      ),
      'endereco': MapValidator(
        locale: 'pt_BR',
        {
          'tipo_logradouro': StringValidator(
            fieldName: 'tipo_logradouro',
            minLength: 2,
            maxLength: 20,
          ),
          'logradouro': StringValidator(
            fieldName: 'logradouro',
            minLength: 3,
            maxLength: 100,
          ),
          'bairro': StringValidator(
            fieldName: 'bairro',
            minLength: 3,
            maxLength: 50,
          ),
        },
        fieldName: 'endereco',
      ),
      'hobbies': ListValidator(
        locale: 'pt_BR',
        isRequired: true,
        StringValidator(
          fieldName: 'hobbies',
          minLength: 3,
          maxLength: 50,
        ),
        fieldName: 'hobbies',
      ),
    });

    var data = {
      'nome': 'Fernando Maia',
      'endereco': {
        'tipo_logradouro': 'RUA',
        'logradouro': 'Geralda de Araújo Maia Costa',
        'bairro': '',
      },
      // 'hobbies': ['Desenvolvimento de Software', 'Natação', 'M'],
      'hobbies': null,
    };

    try {
      schema.validate(data);
      print('Os dados são válidos.');
    } catch (e) {
      if (e is ValidatorException) {
        print('Erros de validação: ${e.errors}');
      }
    }
  });
}
