import 'package:mapify_generator/src/writers/writers.dart';
import 'package:test/test.dart';

import '../utils/resource_reader.dart';
import '../utils/class_element_utils.dart';

void main() {
  test('Test getConstructorFields', () async {
    final inputClassElement = await createClassElement(
      clazz: '''
      
      class Foo {
        final String id;
        final List<CustomObject> items;
        final CustomObject customObject1;
        final CustomObject? customObject2;
        
        const Foo({ required this.id, required this.items, required this.customObject1, this.customObject2,})
        
        double get justASetter => 0.8;
        
        final String justAFinal = '';
      }
       
      ''',
      extra: 'class CustomObject {}',
    );

    final extensionWriter = ExtensionWriter(
      mapperClassName: 'FooMapper',
      inputClassName: 'Foo',
      inputTypeClassElement: inputClassElement,
      outputTypeClassElements: [],
    );

    final constructorFields = extensionWriter.getConstructorFields(inputClassElement);
    expect(
      constructorFields.map((e) => e.name).toSet(),
      {
        'id', 'items', 'customObject1', 'customObject2'
      },
    );
  });

  test('Test extension writer output', () async {
    final inputClassElement = await createClassElement(
      clazz: '''
      
      class Foo {
        final String id;
        final List<CustomObject> items;
        final CustomObject customObject1;
        final CustomObject? customObject2;
        
        const Foo({ required this.id, required this.items, required this.customObject1, this.customObject2,})
      }
       
      ''',
      extra: 'class CustomObject {}',
    );

    final outputEntityClassElement = await createClassElement(
      clazz: '''
      
      class FooEntity {
        final String id;
        final List<CustomObjectEntity> items;
        final CustomObjectEntity customObject1;
        final CustomObjectEntity? customObject2;
        final String unknown;
        final String? unknown2;
        
        const FooEntity({ 
          required this.id, 
          required this.items, 
          required this.customObject1, 
          required this.unknown,
          this.unknown2,
          this.customObject2,
        })
      }
       
      ''',
      extra: 'class CustomObjectEntity {}',
    );

    final outputDtoClassElement = await createClassElement(
      clazz: '''
      
      class FooDto {
        final String id;
        final List<CustomObjectDto> items;
        final CustomObjectDto customObject1;
        final CustomObjectDto? customObject2;
        final String unknown;
        final String? unknown2;
        
        const FooDto({ 
          required this.id, 
          required this.items, 
          required this.customObject1, 
          required this.unknown,
          this.unknown2,
          this.customObject2,
        })
      }
       
      ''',
      extra: 'class CustomObjectDto {}',
    );

    final extensionWriter = ExtensionWriter(
      mapperClassName: 'FooMapper',
      inputClassName: 'Foo',
      inputTypeClassElement: inputClassElement,
      outputTypeClassElements: [
        outputDtoClassElement,
        outputEntityClassElement,
      ],
    );

    final code = extensionWriter.write();
    expect(code, await readResource('expected_file_output.txt'));
  });
}
