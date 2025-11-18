import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../../accounts_feature.dart';

class DeleteAccount {
  final AccountsRepository repository;

  DeleteAccount(this.repository);

  Future<Either<ErrorItem, bool>> call(String accountId) {
    return repository.deleteAccount(accountId);
  }
}
