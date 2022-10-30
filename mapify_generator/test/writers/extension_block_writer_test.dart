import 'package:mapify_generator/src/writers/writers.dart';
import 'package:test/test.dart';

import '../utils/class_element_utils.dart';
import '../utils/field_element_utils.dart';
import '../utils/resource_reader.dart';

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
    print(output);

    expect(
      output,
      await readResource('expected_block_output.txt'),
    );
  });
}
