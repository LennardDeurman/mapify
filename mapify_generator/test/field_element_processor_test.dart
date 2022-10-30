import 'package:mapify_generator/src/processors/field_conversion_processor.dart';
import 'package:test/test.dart';

import 'utils/field_element_utils.dart';

void main() {
  test('Without input field', () async {
    final outputField = await generateFieldElement('''
      final int id;
    ''');

    final conversionStrategy = FieldConversionProcessor.to(outputField).getConversionStrategy();
    expect(conversionStrategy, FieldConversionStrategy.noInputFieldAvailable);
  });

  test('With input field and same output field', () async {
    final inputField = await generateFieldElement('''
      final int id;
    ''');

    final outputField = await generateFieldElement('''
      final int id;
    ''');

    final conversionStrategy = FieldConversionProcessor.to(
      outputField,
      from: inputField,
    ).getConversionStrategy();

    expect(conversionStrategy, FieldConversionStrategy.direct);
  });

  test('With input field and same output field but different type', () async {
    final inputField = await generateFieldElement('''
      final CustomObject id;
    ''');

    final outputField = await generateFieldElement('''
      final CustomObjectEntity id;
    ''');

    final conversionStrategy = FieldConversionProcessor.to(
      outputField,
      from: inputField,
    ).getConversionStrategy();

    expect(conversionStrategy, FieldConversionStrategy.mapSingleSubType);
  });

  test('With input field and same output field but different type', () async {
    final inputField = await generateFieldElement('''
      final List<CustomObject> items;
    ''');

    final outputField = await generateFieldElement('''
      final List<CustomObjectEntity> items;
    ''');

    final conversionStrategy = FieldConversionProcessor.to(
      outputField,
      from: inputField,
    ).getConversionStrategy();

    expect(conversionStrategy, FieldConversionStrategy.mapListSubType);
  });
}
