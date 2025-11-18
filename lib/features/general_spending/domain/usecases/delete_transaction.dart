import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class DeleteTransaction {
  DeleteTransaction(this.repository);

  final TransactionsRepository repository;

  Future<Either<ErrorItem, bool>> call(String transactionId) {
    if (transactionId.trim().isEmpty) {
      return Future.value(
        Either.left(
          ErrorItem(
            code: 'INVALID_TRANSACTION_ID',
            message: 'No se pudo identificar la transacción.',
          ),
        ),
      );
    }

    return repository.deleteTransaction(transactionId);
  }
}
