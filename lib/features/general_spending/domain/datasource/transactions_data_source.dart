import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../domain.dart';

abstract class TransactionsDataSource {
  Future<Either<ErrorItem, List<Map<String, dynamic>>>> getUserTransactions(
    String userId,
  );

  Future<Either<ErrorItem, Map<String, dynamic>>> getTransactionDetail(
    String transactionId,
  );

  Future<Either<ErrorItem, Map<String, dynamic>>> createTransaction(
    CreateTransactionInput input,
  );

  Future<Either<ErrorItem, Map<String, dynamic>>> updateTransaction(
    UpdateTransactionInput input,
  );

  Future<Either<ErrorItem, bool>> deleteTransaction(String transactionId);
}
