part of 'accounts_bloc.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object?> get props => [];
}

class AccountsFetchRequested extends AccountsEvent {
  const AccountsFetchRequested();
}

class AccountsRefreshRequested extends AccountsEvent {
  const AccountsRefreshRequested();
}

class AccountCreateRequested extends AccountsEvent {
  const AccountCreateRequested({
    required this.name,
    required this.type,
    this.balance = 0,
    this.currency = 'USD',
    this.icon = '💵',
    this.color = '#00B894',
    this.isActive = true,
  });

  final String name;
  final String type;
  final double balance;
  final String currency;
  final String icon;
  final String color;
  final bool isActive;

  @override
  List<Object?> get props => [
        name,
        type,
        balance,
        currency,
        icon,
        color,
        isActive,
      ];
}

class AccountDeleteRequested extends AccountsEvent {
  const AccountDeleteRequested(this.accountId);

  final String accountId;

  @override
  List<Object?> get props => [accountId];
}
