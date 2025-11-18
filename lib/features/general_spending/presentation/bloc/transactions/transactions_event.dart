part of 'transactions_bloc.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

class TransactionsFetchRequested extends TransactionsEvent {
  const TransactionsFetchRequested();
}

class TransactionsRefreshRequested extends TransactionsEvent {
  const TransactionsRefreshRequested();
}

class TransactionDetailRequested extends TransactionsEvent {
  const TransactionDetailRequested(this.transactionId);

  final String transactionId;

  @override
  List<Object?> get props => [transactionId];
}

class TransactionClearDetailRequested extends TransactionsEvent {
  const TransactionClearDetailRequested();
}

class TransactionCreateRequested extends TransactionsEvent {
  const TransactionCreateRequested({
    required this.accountId,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    this.categoryId,
    this.description,
  });

  final String accountId;
  final String? categoryId;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String? description;

  @override
  List<Object?> get props => [
        accountId,
        categoryId,
        title,
        amount,
        date,
        type,
        description,
      ];
}

class TransactionUpdateRequested extends TransactionsEvent {
  const TransactionUpdateRequested({
    required this.transactionId,
    required this.accountId,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    this.categoryId,
    this.description,
  });

  final String transactionId;
  final String accountId;
  final String? categoryId;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String? description;

  @override
  List<Object?> get props => [
        transactionId,
        accountId,
        categoryId,
        title,
        amount,
        date,
        type,
        description,
      ];
}

class TransactionDeleteRequested extends TransactionsEvent {
  const TransactionDeleteRequested(this.transactionId);

  final String transactionId;

  @override
  List<Object?> get props => [transactionId];
}
