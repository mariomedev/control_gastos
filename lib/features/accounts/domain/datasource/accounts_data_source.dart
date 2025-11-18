import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../../accounts_feature.dart';

abstract class AccountsDataSource {
  Future<Either<ErrorItem, List<Map<String, dynamic>>>> getUserAccounts(
    String userId,
  );

  Future<Either<ErrorItem, Map<String, dynamic>>> createAccount(
    CreateAccountInput input,
  );

  Future<Either<ErrorItem, bool>> deleteAccount(String accountId);
}
