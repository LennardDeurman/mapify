import 'member_entity.dart';

class AccountEntity {
  final String id;
  final List<String> activeMemberIds;
  final List<MemberEntity> members;

  const AccountEntity({
    required this.id,
    required this.activeMemberIds,
    required this.members,
  });
}
