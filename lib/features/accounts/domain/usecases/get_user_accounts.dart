import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../../accounts_feature.dart';

class GetUserAccounts {
  final AccountsRepository repository;

  GetUserAccounts(this.repository);

  Future<Either<ErrorItem, List<AccountEntity>>> call(String userId) {
    return repository.getUserAccounts(userId);
  }
}
