import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../domain.dart';

abstract class TransactionsRepository {
  Future<Either<ErrorItem, List<TransactionEntity>>> getUserTransactions(
    String userId,
  );

  Future<Either<ErrorItem, TransactionEntity>> getTransactionDetail(
    String transactionId,
  );

  Future<Either<ErrorItem, TransactionEntity>> createTransaction(
    CreateTransactionInput input,
  );

  Future<Either<ErrorItem, TransactionEntity>> updateTransaction(
    UpdateTransactionInput input,
  );

  Future<Either<ErrorItem, bool>> deleteTransaction(String transactionId);
}
