import 'package:mapify_generator/src/processors/processors.dart';
import 'package:mapify_generator/src/writers/writers.dart';
import 'package:test/test.dart';

import '../utils/field_element_utils.dart';

void main() {
  const className = 'Foo';

  Future<String> _getExtensionLine({
    required String fieldStr,
    required FieldConversionStrategy strategy,
  }) async {
    final field = await generateFieldElement(fieldStr);

    final extensionLineWriter = ExtensionLineWriter(
      field: field,
      className: className,
      strategy: strategy,
    );

    return extensionLineWriter.write();
  }

  group('FieldConversionStrategy.direct', () {
    test('FieldConversionStrategy.direct should output correct string', () async {
      final output = await _getExtensionLine(
        fieldStr: 'final int id;',
        strategy: FieldConversionStrategy.direct,
      );

      expect(output, "id: mapper.convert<int>(toFieldName: 'id', type: Foo,) ?? id,");
    });

    test('FieldConversionStrategy.direct should output correct string - isNullable', () async {
      final output = await _getExtensionLine(
        fieldStr: 'final int? id;',
        strategy: FieldConversionStrategy.direct,
      );

      expect(output, "id: mapper.convert<int>(toFieldName: 'id', type: Foo,) ?? id,");
    });
  });

  group('FieldConversionStrategy.noInputFieldAvailable', () {
    test('FieldConversionStrategy.noInputFieldAvailable should output correct string', () async {
      final output = await _getExtensionLine(
        fieldStr: 'final int id;',
        strategy: FieldConversionStrategy.noInputFieldAvailable,
      );

      expect(output, "id: mapper.convert<int>(toFieldName: 'id', type: Foo,)!,");
    });

    test('FieldConversionStrategy.noInputFieldAvailable should output correct string - isNullable', () async {
      final output = await _getExtensionLine(
        fieldStr: 'final int? id;',
        strategy: FieldConversionStrategy.noInputFieldAvailable,
      );

      expect(output, "id: mapper.convert<int>(toFieldName: 'id', type: Foo,),");
    });
  });

  group('FieldConversionStrategy.mapSingleSubType', () {
    test('FieldConversionStrategy.mapSingleSubType should output correct string', () async {
      final output = await _getExtensionLine(
        fieldStr: 'final CustomObject customObject;',
        strategy: FieldConversionStrategy.mapSingleSubType,
      );

      expect(output, "customObject: mapper.convert<CustomObject>(toFieldName: 'customObject', type: Foo,) ?? customObject.toCustomObject(),");
    });

    test('FieldConversionStrategy.mapSingleSubType should output correct string - isNullable', () async {
      final output = await _getExtensionLine(
        fieldStr: 'final CustomObject? customObject;',
        strategy: FieldConversionStrategy.mapSingleSubType,
      );

      expect(output, "customObject: mapper.convert<CustomObject>(toFieldName: \'customObject\', type: Foo,) ?? customObject?.toCustomObject(),");
    });
  });

  group('FieldConversionStrategy.mapListSubType', () {
    test('FieldConversionStrategy.mapListSubType should output correct string', () async {
      final output = await _getExtensionLine(
        fieldStr: 'final List<CustomObject> customObjects;',
        strategy: FieldConversionStrategy.mapListSubType,
      );

      expect(output, "customObjects: mapper.convert<List<CustomObject>>(toFieldName: 'customObjects', type: Foo,) ?? customObjects.map((e) => e.toCustomObject()).toList(),");
    });

    test('FieldConversionStrategy.mapListSubType should output correct string - isNullable', () async {
      final output = await _getExtensionLine(
        fieldStr: 'final List<CustomObject>? customObjects;',
        strategy: FieldConversionStrategy.mapListSubType,
      );

      expect(output, "customObjects: mapper.convert<List<CustomObject>>(toFieldName: 'customObjects', type: Foo,) ?? customObjects?.map((e) => e.toCustomObject()).toList(),");
    });
  });



}
