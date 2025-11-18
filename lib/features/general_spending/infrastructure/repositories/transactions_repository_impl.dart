import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../mappers/transaction_mapper.dart';

class TransactionsRepositoryImpl extends TransactionsRepository {
  TransactionsRepositoryImpl({required this.dataSource});

  final TransactionsDataSource dataSource;

  @override
  Future<Either<ErrorItem, List<TransactionEntity>>> getUserTransactions(
    String userId,
  ) async {
    final result = await dataSource.getUserTransactions(userId);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (rows) => Either.right(
        rows.map(TransactionMapper.fromMap).toList(growable: false),
      ),
    );
  }

  @override
  Future<Either<ErrorItem, TransactionEntity>> getTransactionDetail(
    String transactionId,
  ) async {
    final result = await dataSource.getTransactionDetail(transactionId);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (row) => Either.right(TransactionMapper.fromMap(row)),
    );
  }

  @override
  Future<Either<ErrorItem, TransactionEntity>> createTransaction(
    CreateTransactionInput input,
  ) async {
    final result = await dataSource.createTransaction(input);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (row) => Either.right(TransactionMapper.fromMap(row)),
    );
  }

  @override
  Future<Either<ErrorItem, TransactionEntity>> updateTransaction(
    UpdateTransactionInput input,
  ) async {
    final result = await dataSource.updateTransaction(input);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (row) => Either.right(TransactionMapper.fromMap(row)),
    );
  }

  @override
  Future<Either<ErrorItem, bool>> deleteTransaction(String transactionId) {
    return dataSource.deleteTransaction(transactionId);
  }
}
