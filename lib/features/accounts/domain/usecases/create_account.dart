import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../../accounts_feature.dart';

class CreateAccount {
  final AccountsRepository repository;

  CreateAccount(this.repository);

  Future<Either<ErrorItem, AccountEntity>> call(
    CreateAccountInput input,
  ) {
    return repository.createAccount(input);
  }
}
