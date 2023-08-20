# Mapify

This library helps mapping similar objects to eachother. 

This library generates extensions based on the original input object to the desired output, and automatically resolves matching fields. 

### How to define? 

Let's consider the following input object:

```
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
```

We have the following output objects in other packages of our main app:


```
class AccountEntity {
  final String id;
  final List<String> activeMemberIds;
  final List<Member> members;

  const AccountEntity({
    required this.id,
    required this.activeMemberIds,
    required this.members,
  });
}

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
```

To generate the required mapping, we define a new dart file, and put the following code: 

```

import 'package:example_api/example_api.dart';
import 'package:example_core/example_core.dart';
import 'package:mapify/mapify.dart';

/// Add child mapper files if there are dependencies
import 'member.dart';

part 'account.g.dart';

@GenerateMapping(
  outputType: [
    AccountDto,
    AccountEntity,
  ],
  inputType: Account,
)
class AccountMapper extends MappingManager<Account> {
  AccountMapper(super.input);
}

```

Now run the build_runner: flutter pub run build_runner build --delete-conflicting-outputs in the project that includes the account mapper, and the mapping
will be generated


