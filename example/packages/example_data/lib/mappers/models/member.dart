import 'package:example_storage/example_storage.dart';
import 'package:example_api/example_api.dart';
import 'package:example_core/example_core.dart';
import 'package:mapify/mapify.dart';

part 'member.g.dart';

@GenerateMapping(
  outputType: [
    MemberDto,
    MemberEntity,
  ],
  inputType: Member,
)
class MemberMapper extends MappingManager<Member> {
  MemberMapper(super.input);
}