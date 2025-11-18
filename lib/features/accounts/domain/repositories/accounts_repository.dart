import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../../accounts_feature.dart';

abstract class AccountsRepository {
  Future<Either<ErrorItem, List<AccountEntity>>> getUserAccounts(
    String userId,
  );

  Future<Either<ErrorItem, AccountEntity>> createAccount(
    CreateAccountInput input,
  );

  Future<Either<ErrorItem, bool>> deleteAccount(String accountId);
}
