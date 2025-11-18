import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class CreateTransaction {
  CreateTransaction(this.repository);

  final TransactionsRepository repository;

  Future<Either<ErrorItem, TransactionEntity>> call(
    CreateTransactionInput input,
  ) async {
    final validationError = _validate(input);
    if (validationError != null) {
      return Either.left(validationError);
    }

    return repository.createTransaction(input);
  }

  ErrorItem? _validate(CreateTransactionInput input) {
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

    if (input.userId.trim().isEmpty) {
      return ErrorItem(
        code: 'INVALID_TRANSACTION_USER',
        message: 'El usuario no es válido.',
      );
    }

    return null;
  }
}
