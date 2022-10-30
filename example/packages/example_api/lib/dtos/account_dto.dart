import 'member_dto.dart';

class AccountDto {
  final String id;
  final List<String> activeMemberIds;
  final List<MemberDto> members;

  const AccountDto({
    required this.id,
    required this.activeMemberIds,
    required this.members,
  });
}
