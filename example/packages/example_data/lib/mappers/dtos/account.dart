import 'package:example_storage/example_storage.dart';
import 'package:example_api/example_api.dart';
import 'package:example_core/example_core.dart';
import 'package:mapify/mapify.dart';

part 'account.g.dart';

@GenerateMapping(
  outputType: [
    AccountEntity,
    Account,
  ],
  inputType: AccountDto,
)
class AccountDtoMapper extends MappingManager<AccountDto> {
  AccountDtoMapper(super.input);
}