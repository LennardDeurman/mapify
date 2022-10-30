import 'member.dart';

class Account {
  final String id;
  final List<String> activeMemberIds;
  final List<Member> members;

  const Account({
    required this.id,
    required this.activeMemberIds,
    required this.members,
  });
}
