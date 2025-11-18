import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:control_gastos/features/general_spending/presentation/bloc/transactions/transactions_bloc.dart';

class TransactionMutationFeedback extends StatelessWidget {
  const TransactionMutationFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      buildWhen: (previous, current) =>
          previous.mutationStatus != current.mutationStatus,
      builder: (context, state) {
        if (state.mutationStatus == TransactionMutationStatus.failure) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              state.mutationMessage.isEmpty
                  ? 'Ocurrió un error, vuelve a intentarlo'
                  : state.mutationMessage,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
