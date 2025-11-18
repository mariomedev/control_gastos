part of 'accounts_bloc.dart';

enum AccountsStatus { initial, loading, success, failure }

enum AccountsMutationStatus { idle, submitting, success, failure }

class AccountsState extends Equatable {
  const AccountsState({
    this.status = AccountsStatus.initial,
    this.accounts = const <AccountEntity>[],
    this.errorMessage = '',
    this.mutationStatus = AccountsMutationStatus.idle,
    this.mutationMessage = '',
  });

  final AccountsStatus status;
  final List<AccountEntity> accounts;
  final String errorMessage;
  final AccountsMutationStatus mutationStatus;
  final String mutationMessage;

  double get totalBalance =>
      accounts.fold(0, (total, account) => total + account.balance);

  AccountsState copyWith({
    AccountsStatus? status,
    List<AccountEntity>? accounts,
    String? errorMessage,
    AccountsMutationStatus? mutationStatus,
    String? mutationMessage,
  }) {
    return AccountsState(
      status: status ?? this.status,
      accounts: accounts ?? this.accounts,
      errorMessage: errorMessage ?? this.errorMessage,
      mutationStatus: mutationStatus ?? this.mutationStatus,
      mutationMessage: mutationMessage ?? this.mutationMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        accounts,
        errorMessage,
        mutationStatus,
        mutationMessage,
      ];
}
