import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetUserTransactions {
  GetUserTransactions(this.repository);

  final TransactionsRepository repository;

  Future<Either<ErrorItem, List<TransactionEntity>>> call(String userId) {
    return repository.getUserTransactions(userId);
  }
}
