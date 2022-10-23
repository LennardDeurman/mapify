import 'package:test/test.dart';

import 'package:mapify_generator/src/extensions/type_extension.dart';
import '../utils/type_utils.dart';

void main() {
  group('isNullable', () {
    test('nullable string is nullable', () async {
      final type = await getDartTypeFromDeclaration("final String? foo = '';");

      final actual = type.isNullable;

      expect(actual, isTrue);
    });

    test('non-nullable string is non-nullable', () async {
      final type = await getDartTypeFromDeclaration("final String foo = '';");

      final actual = type.isNullable;

      expect(actual, isFalse);
    });
  });

  group('firstGenericTypeOrNull', () {
    test('generic type is null when there is a list without generic type', () async {
      final type = await getDartTypeFromDeclaration('final String foo = '';');

      final actual = type.firstGenericTypeOrNull;

      expect(actual, isNull);
    });

    test('generic type is notNull when there is a list without generic type', () async {
      final type = await getDartTypeFromDeclaration('final List<String> foo = [];');

      final actual = type.firstGenericTypeOrNull;

      expect(actual, isNotNull);
    });
  });
}
