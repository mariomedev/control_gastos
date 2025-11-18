import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:control_gastos/core/core.dart';
import 'package:control_gastos/features/accounts/accounts_feature.dart';

import 'inline_action_message.dart';

class TransactionAccountField extends StatelessWidget {
  const TransactionAccountField({
    super.key,
    required this.selectedAccountId,
    required this.onChanged,
  });

  final String? selectedAccountId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        switch (state.status) {
          case AccountsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case AccountsStatus.failure:
            return InlineActionMessage(
              message: state.errorMessage.isEmpty
                  ? 'No se pudieron cargar las cuentas'
                  : state.errorMessage,
              actionLabel: 'Reintentar',
              onPressed: () => context
                  .read<AccountsBloc>()
                  .add(const AccountsFetchRequested()),
            );
          case AccountsStatus.success:
            if (state.accounts.isEmpty) {
              return InlineActionMessage(
                message: 'Crea una cuenta antes de registrar transacciones.',
                actionLabel: 'Ir a cuentas',
                onPressed: () {
                  Navigator.of(context).maybePop();
                  context.push(RoutePaths.accounts);
                },
              );
            }
            return DropdownButtonFormField<String>(
              initialValue: selectedAccountId,
              decoration: const InputDecoration(labelText: 'Cuenta'),
              items: state.accounts
                  .map(
                    (account) => DropdownMenuItem(
                      value: account.id,
                      child: Text(account.name),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Selecciona una cuenta';
                }
                return null;
              },
            );
          case AccountsStatus.initial:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
