import 'package:mapify_generator/src/writers/writers.dart';
import 'package:test/test.dart';

import '../utils/class_element_utils.dart';

void main() {
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

    expect(
      code,
      'extension FooMapperExtension on Foo{\n'
      'FooDto toFooDto() {\n'
      'final mapper = FooMapper(this);\n'
      'return FooDto(\n'
      'id: mapper.convert<String>(toFieldName: \'id\', type: FooDto,) ?? id,\n'
      'items: mapper.convert<List<CustomObjectDto>>(toFieldName: \'items\', type: FooDto,) ?? items.map((e) => e.toCustomObjectDto()),\n'
      'customObject1: mapper.convert<CustomObjectDto>(toFieldName: \'customObject1\', type: FooDto,) ?? customObject1.toCustomObjectDto(),\n'
      'customObject2: mapper.convert<CustomObjectDto>(toFieldName: \'customObject2\', type: FooDto,) ?? customObject2?.toCustomObjectDto(),\n'
      'unknown: mapper.convert<String>(toFieldName: \'unknown\', type: FooDto,)!,\n'
      'unknown2: mapper.convert<String>(toFieldName: \'unknown2\', type: FooDto,),\n'
      ');\n'
      '}\n'
      'FooEntity toFooEntity() {\n'
      'final mapper = FooMapper(this);\n'
      'return FooEntity(\n'
      'id: mapper.convert<String>(toFieldName: \'id\', type: FooEntity,) ?? id,\n'
      'items: mapper.convert<List<CustomObjectEntity>>(toFieldName: \'items\', type: FooEntity,) ?? items.map((e) => e.toCustomObjectEntity()),\n'
      'customObject1: mapper.convert<CustomObjectEntity>(toFieldName: \'customObject1\', type: FooEntity,) ?? customObject1.toCustomObjectEntity(),\n'
      'customObject2: mapper.convert<CustomObjectEntity>(toFieldName: \'customObject2\', type: FooEntity,) ?? customObject2?.toCustomObjectEntity(),\n'
      'unknown: mapper.convert<String>(toFieldName: \'unknown\', type: FooEntity,)!,\n'
      'unknown2: mapper.convert<String>(toFieldName: \'unknown2\', type: FooEntity,),\n'
      ');\n'
      '}\n'
      '}\n'
      '',
    );
  });
}
