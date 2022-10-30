import 'package:mapify_generator/src/writers/writers.dart';
import 'package:test/test.dart';

import '../utils/class_element_utils.dart';
import '../utils/field_element_utils.dart';

void main() {
  test('Test response of extension block writer', () async {
    final inputTypeClassElement = await createClassElement(clazz: '''
      
      class Foo {
        final String id;
        final List<CustomObject> items;
        final CustomObject customObject1;
        final CustomObject? customObject2;
        
        const Foo({ required this.id, required this.items, required this.customObject1, this.customObject2,})
      }
       
      ''', extra: '''
          
          class CustomObject {}
          
          ''');

    final fields = [
      await generateFieldElement('final String id;'),
      await generateFieldElement('final String unknown;'),
      await generateFieldElement('final String? unknown2;'),
      await generateFieldElement('final List<CustomObjectEntity> items;'),
      await generateFieldElement('final CustomObjectEntity customObject1;'),
      await generateFieldElement('final CustomObjectEntity? customObject2;'),
    ];

    final extensionBlockWriter = ExtensionBlockWriter(
      outputClassName: 'FooEntity',
      mapperClassName: 'FooMapper',
      fields: fields,
      inputTypeClassElement: inputTypeClassElement,
    );

    final output = extensionBlockWriter.write();

    expect(
      output,
      'FooEntity toFooEntity() {\n'
      'final mapper = FooMapper(this);\n'
      'return FooEntity(\n'
      'id: mapper.convert<String>(toFieldName: \'id\', type: FooEntity,) ?? id,\n'
      'unknown: mapper.convert<String>(toFieldName: \'unknown\', type: FooEntity,)!,\n'
      'unknown2: mapper.convert<String>(toFieldName: \'unknown2\', type: FooEntity,),\n'
      'items: mapper.convert<List<CustomObjectEntity>>(toFieldName: \'items\', type: FooEntity,) ?? items.map((e) => e.toCustomObjectEntity()),\n'
      'customObject1: mapper.convert<CustomObjectEntity>(toFieldName: \'customObject1\', type: FooEntity,) ?? customObject1.toCustomObjectEntity(),\n'
      'customObject2: mapper.convert<CustomObjectEntity>(toFieldName: \'customObject2\', type: FooEntity,) ?? customObject2?.toCustomObjectEntity(),\n'
      ');\n'
      '}\n'
      '',
    );
  });
}
