import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetTransactionDetail {
  GetTransactionDetail(this.repository);

  final TransactionsRepository repository;

  Future<Either<ErrorItem, TransactionEntity>> call(String transactionId) {
    return repository.getTransactionDetail(transactionId);
  }
}
