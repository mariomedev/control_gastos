part of 'transactions_bloc.dart';

enum TransactionsStatus { initial, loading, success, failure }

enum TransactionDetailStatus { idle, loading, success, failure }

enum TransactionMutationStatus { idle, submitting, success, failure }

class TransactionsState extends Equatable {
  const TransactionsState({
    this.status = TransactionsStatus.initial,
    this.transactions = const <TransactionEntity>[],
    this.errorMessage = '',
    this.detailStatus = TransactionDetailStatus.idle,
    this.selectedTransaction,
    this.detailErrorMessage = '',
    this.mutationStatus = TransactionMutationStatus.idle,
    this.mutationMessage = '',
  });

  final TransactionsStatus status;
  final List<TransactionEntity> transactions;
  final String errorMessage;
  final TransactionDetailStatus detailStatus;
  final TransactionEntity? selectedTransaction;
  final String detailErrorMessage;
  final TransactionMutationStatus mutationStatus;
  final String mutationMessage;

  double get totalIncome => transactions
      .where((transaction) => transaction.type.isIncome)
      .fold(0, (total, transaction) => total + transaction.amount);

  double get totalExpense => transactions
      .where((transaction) => transaction.type.isExpense)
      .fold(0, (total, transaction) => total + transaction.amount);

  double get balance => totalIncome - totalExpense;

  TransactionsState copyWith({
    TransactionsStatus? status,
    List<TransactionEntity>? transactions,
    String? errorMessage,
    TransactionDetailStatus? detailStatus,
    TransactionEntity? selectedTransaction,
    bool clearSelectedTransaction = false,
    String? detailErrorMessage,
    TransactionMutationStatus? mutationStatus,
    String? mutationMessage,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage ?? this.errorMessage,
      detailStatus: detailStatus ?? this.detailStatus,
      selectedTransaction: clearSelectedTransaction
          ? null
          : selectedTransaction ?? this.selectedTransaction,
      detailErrorMessage: detailErrorMessage ?? this.detailErrorMessage,
      mutationStatus: mutationStatus ?? this.mutationStatus,
      mutationMessage: mutationMessage ?? this.mutationMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transactions,
        errorMessage,
        detailStatus,
        selectedTransaction,
        detailErrorMessage,
        mutationStatus,
        mutationMessage,
      ];
}
