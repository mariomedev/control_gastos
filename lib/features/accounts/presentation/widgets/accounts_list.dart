import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../bloc/accounts/accounts_bloc.dart';
import 'account_card.dart';
import 'accounts_overview_card.dart';

class AccountsList extends StatelessWidget {
  AccountsList({
    super.key,
    AccountsBloc? bloc,
    this.onSeeAll,
    this.onAddAccount,
    this.onDeleteAccount,
  }) : _bloc = bloc ?? getIt<AccountsBloc>();

  final AccountsBloc _bloc;
  final VoidCallback? onSeeAll;
  final VoidCallback? onAddAccount;
  final ValueChanged<AccountEntity>? onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      bloc: _bloc,
      builder: (context, state) {
        final children = <Widget>[
          AccountsOverviewCard(
            totalBalance: state.totalBalance,
            totalAccounts: state.accounts.length,
            onAddAccount: onAddAccount,
          ),
        ];

        if (onSeeAll != null) {
          children.add(
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onSeeAll,
                icon: const Icon(Icons.open_in_new),
                label: const Text('Ver todas las cuentas'),
              ),
            ),
          );
        }

        switch (state.status) {
          case AccountsStatus.loading:
            children.add(const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator()),
            ));
            break;
          case AccountsStatus.failure:
            children.add(_AccountsError(
              message: state.errorMessage.isEmpty
                  ? 'Ocurrió un error'
                  : state.errorMessage,
              onRetry: () => _bloc.add(const AccountsRefreshRequested()),
            ));
            break;
          case AccountsStatus.success:
            if (state.accounts.isEmpty) {
              children.add(
                _EmptyAccounts(onAddAccount: onAddAccount ?? () {}),
              );
            } else {
              children.addAll(
                state.accounts
                    .map(
                      (account) => AccountCard(
                        account: account,
                        onDelete: onDeleteAccount == null
                            ? null
                            : () => onDeleteAccount!(account),
                      ),
                    )
                    .toList(growable: false),
              );
            }
            break;
          case AccountsStatus.initial:
            children.add(const SizedBox.shrink());
            break;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        );
      },
    );
  }
}

class _AccountsError extends StatelessWidget {
  const _AccountsError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colors.errorContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No se pudieron cargar las cuentas',
            style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: theme.bodySmall,
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}

class _EmptyAccounts extends StatelessWidget {
  const _EmptyAccounts({required this.onAddAccount});

  final VoidCallback onAddAccount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.surfaceContainerHighest),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aún no tienes cuentas registradas',
            style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega tu primera cuenta para empezar a registrar tus movimientos.',
            style: theme.bodySmall?.copyWith(color: colors.outline),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onAddAccount,
            icon: const Icon(Icons.add),
            label: const Text('Agregar cuenta'),
          ),
        ],
      ),
    );
  }
}
