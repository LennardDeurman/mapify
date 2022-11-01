import 'package:example_storage/example_storage.dart';
import 'package:example_api/example_api.dart';
import 'package:example_core/example_core.dart';
import 'package:mapify/mapify.dart';

part 'member.g.dart';

@GenerateMapping(
  outputType: [
    MemberEntity,
    Member,
  ],
  inputType: MemberDto,
)
class MemberDtoMapper extends MappingManager<MemberDto> {
  MemberDtoMapper(super.input);
}