import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/domain.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({
    required GetUserTransactions getUserTransactions,
    required GetTransactionDetail getTransactionDetail,
    required CreateTransaction createTransaction,
    required UpdateTransaction updateTransaction,
    required DeleteTransaction deleteTransaction,
  })  : _getUserTransactions = getUserTransactions,
        _getTransactionDetail = getTransactionDetail,
        _createTransaction = createTransaction,
        _updateTransaction = updateTransaction,
        _deleteTransaction = deleteTransaction,
        super(const TransactionsState()) {
    on<TransactionsFetchRequested>(_onFetchRequested);
    on<TransactionsRefreshRequested>(_onRefreshRequested);
    on<TransactionDetailRequested>(_onDetailRequested);
    on<TransactionClearDetailRequested>(_onClearDetailRequested);
    on<TransactionCreateRequested>(_onCreateRequested);
    on<TransactionUpdateRequested>(_onUpdateRequested);
    on<TransactionDeleteRequested>(_onDeleteRequested);
  }

  final GetUserTransactions _getUserTransactions;
  final GetTransactionDetail _getTransactionDetail;
  final CreateTransaction _createTransaction;
  final UpdateTransaction _updateTransaction;
  final DeleteTransaction _deleteTransaction;

  Future<void> _onFetchRequested(
    TransactionsFetchRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    await _loadTransactions(emit, forceLoading: true);
  }

  Future<void> _onRefreshRequested(
    TransactionsRefreshRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    await _loadTransactions(emit, forceLoading: false);
  }

  Future<void> _loadTransactions(
    Emitter<TransactionsState> emit, {
    required bool forceLoading,
  }) async {
    if (forceLoading) {
      emit(state.copyWith(status: TransactionsStatus.loading));
    }

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      emit(
        state.copyWith(
          status: TransactionsStatus.failure,
          errorMessage: 'Usuario no autenticado',
        ),
      );
      return;
    }

    final result = await _getUserTransactions(userId);

    result.fold(
      ifLeft: (error) => emit(
        state.copyWith(
          status: TransactionsStatus.failure,
          errorMessage: error.message,
        ),
      ),
      ifRight: (transactions) => emit(
        state.copyWith(
          status: TransactionsStatus.success,
          transactions: transactions,
          errorMessage: '',
        ),
      ),
    );
  }

  Future<void> _onDetailRequested(
    TransactionDetailRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(
      state.copyWith(
        detailStatus: TransactionDetailStatus.loading,
        detailErrorMessage: '',
      ),
    );

    final result = await _getTransactionDetail(event.transactionId);

    result.fold(
      ifLeft: (error) => emit(
        state.copyWith(
          detailStatus: TransactionDetailStatus.failure,
          detailErrorMessage: error.message,
          clearSelectedTransaction: true,
        ),
      ),
      ifRight: (transaction) => emit(
        state.copyWith(
          detailStatus: TransactionDetailStatus.success,
          selectedTransaction: transaction,
          detailErrorMessage: '',
        ),
      ),
    );
  }

  void _onClearDetailRequested(
    TransactionClearDetailRequested event,
    Emitter<TransactionsState> emit,
  ) {
    emit(
      state.copyWith(
        detailStatus: TransactionDetailStatus.idle,
        detailErrorMessage: '',
        clearSelectedTransaction: true,
      ),
    );
  }

  Future<void> _onCreateRequested(
    TransactionCreateRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    _emitMutationState(emit, TransactionMutationStatus.submitting);

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      _emitMutationState(
        emit,
        TransactionMutationStatus.failure,
        message: 'Usuario no autenticado',
      );
      _emitMutationState(emit, TransactionMutationStatus.idle);
      return;
    }

    final input = CreateTransactionInput(
      userId: userId,
      accountId: event.accountId,
      categoryId: event.categoryId,
      title: event.title,
      amount: event.amount,
      date: event.date,
      type: event.type,
      description: event.description,
    );

    final result = await _createTransaction(input);

    await result.fold<Future<void>>(
      ifLeft: (error) async {
        _emitMutationState(
          emit,
          TransactionMutationStatus.failure,
          message: error.message,
        );
      },
      ifRight: (_) async {
        await _loadTransactions(emit, forceLoading: false);
        _emitMutationState(
          emit,
          TransactionMutationStatus.success,
          message:
              event.type.isExpense ? 'Gasto registrado' : 'Ingreso registrado',
        );
      },
    );

    _emitMutationState(emit, TransactionMutationStatus.idle);
  }

  Future<void> _onUpdateRequested(
    TransactionUpdateRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    _emitMutationState(emit, TransactionMutationStatus.submitting);

    final input = UpdateTransactionInput(
      transactionId: event.transactionId,
      accountId: event.accountId,
      categoryId: event.categoryId,
      title: event.title,
      amount: event.amount,
      date: event.date,
      type: event.type,
      description: event.description,
    );

    final result = await _updateTransaction(input);

    await result.fold<Future<void>>(
      ifLeft: (error) async {
        _emitMutationState(
          emit,
          TransactionMutationStatus.failure,
          message: error.message,
        );
      },
      ifRight: (_) async {
        await _loadTransactions(emit, forceLoading: false);
        _emitMutationState(
          emit,
          TransactionMutationStatus.success,
          message: 'Transacción actualizada',
        );
      },
    );

    _emitMutationState(emit, TransactionMutationStatus.idle);
  }

  Future<void> _onDeleteRequested(
    TransactionDeleteRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    _emitMutationState(emit, TransactionMutationStatus.submitting);

    final result = await _deleteTransaction(event.transactionId);

    await result.fold<Future<void>>(
      ifLeft: (error) async {
        _emitMutationState(
          emit,
          TransactionMutationStatus.failure,
          message: error.message,
        );
      },
      ifRight: (_) async {
        await _loadTransactions(emit, forceLoading: false);
        _emitMutationState(
          emit,
          TransactionMutationStatus.success,
          message: 'Transacción eliminada',
        );
      },
    );

    _emitMutationState(emit, TransactionMutationStatus.idle);
  }

  void _emitMutationState(
    Emitter<TransactionsState> emit,
    TransactionMutationStatus status, {
    String message = '',
  }) {
    emit(
      state.copyWith(
        mutationStatus: status,
        mutationMessage: message,
      ),
    );
  }
}
