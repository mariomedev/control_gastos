import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class UpdateTransaction {
  UpdateTransaction(this.repository);

  final TransactionsRepository repository;

  Future<Either<ErrorItem, TransactionEntity>> call(
    UpdateTransactionInput input,
  ) async {
    final validationError = _validate(input);
    if (validationError != null) {
      return Either.left(validationError);
    }

    return repository.updateTransaction(input);
  }

  ErrorItem? _validate(UpdateTransactionInput input) {
    if (input.transactionId.trim().isEmpty) {
      return ErrorItem(
        code: 'INVALID_TRANSACTION_ID',
        message: 'No se pudo identificar la transacción.',
      );
    }

    final trimmedTitle = input.title.trim();
    if (trimmedTitle.isEmpty) {
      return ErrorItem(
        code: 'INVALID_TRANSACTION_TITLE',
        message: 'El título es obligatorio.',
      );
    }

    if (trimmedTitle.length > 100) {
      return ErrorItem(
        code: 'INVALID_TRANSACTION_TITLE_LENGTH',
        message: 'El título debe tener máximo 100 caracteres.',
      );
    }

    if (input.amount <= 0) {
      return ErrorItem(
        code: 'INVALID_TRANSACTION_AMOUNT',
        message: 'El monto debe ser mayor a 0.',
      );
    }

    if (input.accountId.trim().isEmpty) {
      return ErrorItem(
        code: 'INVALID_TRANSACTION_ACCOUNT',
        message: 'Selecciona una cuenta válida.',
      );
    }

    return null;
  }
}
