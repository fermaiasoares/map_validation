import 'package:faker/faker.dart';
import 'package:map_validation/src/validator_exception.dart';
import 'package:map_validation/src/validator_schema.dart';
import 'package:map_validation/src/validators/boolean_validator.dart';
import 'package:test/test.dart';

void main() {
  test('BooleanValidator - Valid boolean value', () {
    final schema = ValidatorSchema({
      'is_active': BooleanValidator(
        fieldName: 'is_active',
        isRequired: true,
      ),
    }, locale: 'pt_BR');

    final validData = {
      'is_active': faker.randomGenerator.boolean(),
    };

    expect(() => schema.validate(validData), returnsNormally);
  });

  test('BooleanValidator - Invalid boolean value', () {
    final schema = ValidatorSchema({
      'is_active': BooleanValidator(
        fieldName: 'is_active',
        isRequired: true,
      ),
    }, locale: 'pt_BR');

    final invalidData = {
      'is_active': faker.randomGenerator.string(3),
    };

    expect(
      () => schema.validate(invalidData),
      throwsA(isA<ValidatorException>()),
    );
  });

  test('BooleanValidator - Missing required item', () {
    final schema = ValidatorSchema({
      'is_active': BooleanValidator(
        fieldName: 'is_active',
        isRequired: true,
      ),
    }, locale: 'pt_BR');

    final invalidData = <String, dynamic>{};

    expect(
      () => schema.validate(invalidData),
      throwsA(isA<ValidatorException>()),
    );
  });

  test('BooleanValidator - Missing required value', () {
    final schema = ValidatorSchema({
      'is_active': BooleanValidator(
        fieldName: 'is_active',
        isRequired: true,
      ),
    }, locale: 'pt_BR');

    final invalidData = {'is_active': null};

    expect(
      () => schema.validate(invalidData),
      throwsA(isA<ValidatorException>()),
    );
  });
}
