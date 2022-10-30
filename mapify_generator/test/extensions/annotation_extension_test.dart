import 'package:mapify/mapify.dart';
import 'package:mapify_generator/src/extensions/extensions.dart';
import 'package:test/test.dart';

import '../utils/class_element_utils.dart';

void main() {
  const extra = '''
       
       class Member {}
       class MemberEntity {}
       class MemberDto {} 
       
        ''';

  group('hasAnnotation', () {
    test('Should return true if it has annotation', () async {
      final classElement = await createClassElement(
        clazz: '''
        @GenerateMapping(
          outputType: [
            MemberEntity,
            MemberDto,
          ],
          inputType: Member,
        )
        class MemberMapper extends MappingManager<Member> {
          MemberMapper(super.input);
        }
      ''',
        extra: extra,
      );

      final hasAnnotation = classElement.hasAnnotation(GenerateMapping);
      expect(hasAnnotation, true);
    });

    test('Should return false if it has no annotation', () async {
      final classElement = await createClassElement(
        clazz: '''
        class MemberMapper extends MappingManager<Member> {
          MemberMapper(super.input);
        }
      ''',
        extra: extra,
      );

      final hasAnnotation = classElement.hasAnnotation(GenerateMapping);
      expect(hasAnnotation, false);
    });
  });

  group('getAnnotation', () {
    test('Should return true if it has annotation', () async {
      final classElement = await createClassElement(
        clazz: '''
        @GenerateMapping(
          outputType: [
            MemberEntity,
            MemberDto,
          ],
          inputType: Member,
        )
        class MemberMapper extends MappingManager<Member> {
          MemberMapper(super.input);
        }
      ''',
        extra: extra,
      );

      final annotation = classElement.getAnnotation(GenerateMapping);
      expect(annotation, isNotNull);
    });

    test('Should return null if it has no annotation', () async {
      final classElement = await createClassElement(
        clazz: '''
        class MemberMapper extends MappingManager<Member> {
          MemberMapper(super.input);
        }
      ''',
        extra: extra,
      );

      final annotation = classElement.getAnnotation(GenerateMapping);
      expect(annotation, isNull);
    });
  });
}
