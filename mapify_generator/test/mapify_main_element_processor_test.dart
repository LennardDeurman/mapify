import 'package:mapify_generator/src/processors/processors.dart';
import 'package:test/test.dart';

import 'utils/class_element_utils.dart';

void main() {
  const extra = '''
       
       class Member {}
       class MemberEntity {}
       class MemberDto {} 
       
        ''';

  group('MapifyMainElementProcessor', () {
    test('Invalid annotation should lead to exception being thrown', () async {
      final classElement = await createClassElement(
        clazz: '''
        class MemberMapper extends MappingManager<Member> {
          MemberMapper(super.input);
        }
      ''',
        extra: extra,
      );

      expect(() => MapifyMainElementProcessor(classElement), throwsException);
    });

    test('Valid class structure should lead to correct class structure init', () async {
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

      final processor = MapifyMainElementProcessor(classElement);
      expect(
        processor.outputTypeClassElements.map((e) => e.displayName).toList(),
        containsAll(
          <String>['MemberEntity', 'MemberDto'],
        ),
      );

      expect(processor.inputTypeClassElement.displayName, 'Member');

      expect(
        processor.inputClassName,
        'Member',
      );
    });
  });
}
