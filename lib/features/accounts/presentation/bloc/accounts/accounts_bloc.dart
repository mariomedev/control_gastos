import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/domain.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required GetUserAccounts getUserAccounts,
    required CreateAccount createAccount,
    required DeleteAccount deleteAccount,
  })  : _getUserAccounts = getUserAccounts,
        _createAccount = createAccount,
        _deleteAccount = deleteAccount,
        super(const AccountsState()) {
    on<AccountsFetchRequested>(_onFetchRequested);
    on<AccountsRefreshRequested>(_onRefreshRequested);
    on<AccountCreateRequested>(_onCreateRequested);
    on<AccountDeleteRequested>(_onDeleteRequested);
  }

  final GetUserAccounts _getUserAccounts;
  final CreateAccount _createAccount;
  final DeleteAccount _deleteAccount;

  Future<void> _onFetchRequested(
    AccountsFetchRequested event,
    Emitter<AccountsState> emit,
  ) async {
    await _loadAccounts(emit, forceLoading: true);
  }

  Future<void> _onRefreshRequested(
    AccountsRefreshRequested event,
    Emitter<AccountsState> emit,
  ) async {
    await _loadAccounts(emit, forceLoading: true);
  }

  Future<void> _loadAccounts(
    Emitter<AccountsState> emit, {
    required bool forceLoading,
  }) async {
    if (forceLoading) {
      emit(state.copyWith(status: AccountsStatus.loading));
    }

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      emit(
        state.copyWith(
          status: AccountsStatus.failure,
          errorMessage: 'Usuario no autenticado',
        ),
      );
      return;
    }

    final result = await _getUserAccounts(userId);

    result.fold(
      ifLeft: (error) => emit(
        state.copyWith(
          status: AccountsStatus.failure,
          errorMessage: error.message,
        ),
      ),
      ifRight: (accounts) => emit(
        state.copyWith(
          status: AccountsStatus.success,
          accounts: accounts,
          errorMessage: '',
        ),
      ),
    );
  }

  Future<void> _onCreateRequested(
    AccountCreateRequested event,
    Emitter<AccountsState> emit,
  ) async {
    _emitMutationState(
      emit,
      AccountsMutationStatus.submitting,
    );

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      _emitMutationState(
        emit,
        AccountsMutationStatus.failure,
        message: 'Usuario no autenticado',
      );
      _emitMutationState(emit, AccountsMutationStatus.idle);
      return;
    }

    final input = CreateAccountInput(
      userId: userId,
      name: event.name,
      type: event.type,
      balance: event.balance,
      currency: event.currency,
      icon: event.icon,
      color: event.color,
      isActive: event.isActive,
    );

    final result = await _createAccount(input);

    await result.fold<Future<void>>(
      ifLeft: (error) async {
        _emitMutationState(
          emit,
          AccountsMutationStatus.failure,
          message: error.message,
        );
      },
      ifRight: (_) async {
        await _loadAccounts(emit, forceLoading: false);
        _emitMutationState(
          emit,
          AccountsMutationStatus.success,
          message: 'Cuenta creada correctamente',
        );
      },
    );

    _emitMutationState(emit, AccountsMutationStatus.idle);
  }

  Future<void> _onDeleteRequested(
    AccountDeleteRequested event,
    Emitter<AccountsState> emit,
  ) async {
    _emitMutationState(
      emit,
      AccountsMutationStatus.submitting,
    );

    final result = await _deleteAccount(event.accountId);

    await result.fold<Future<void>>(
      ifLeft: (error) async {
        _emitMutationState(
          emit,
          AccountsMutationStatus.failure,
          message: error.message,
        );
      },
      ifRight: (_) async {
        await _loadAccounts(emit, forceLoading: false);
        _emitMutationState(
          emit,
          AccountsMutationStatus.success,
          message: 'Cuenta eliminada',
        );
      },
    );

    _emitMutationState(emit, AccountsMutationStatus.idle);
  }

  void _emitMutationState(
    Emitter<AccountsState> emit,
    AccountsMutationStatus status, {
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
