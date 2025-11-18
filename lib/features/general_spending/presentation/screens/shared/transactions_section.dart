import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import '../../bloc/transactions/transactions_bloc.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({
    super.key,
    required this.state,
    required this.transactions,
    required this.emptyMessage,
    required this.onRetry,
    required this.builder,
  });

  final TransactionsState state;
  final List<TransactionEntity> transactions;
  final String emptyMessage;
  final VoidCallback onRetry;
  final Widget Function(List<TransactionEntity>) builder;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case TransactionsStatus.loading:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(child: CircularProgressIndicator()),
        );
      case TransactionsStatus.failure:
        return _TransactionsError(
            message: state.errorMessage, onRetry: onRetry);
      case TransactionsStatus.success:
        if (transactions.isEmpty) {
          return _TransactionsEmpty(message: emptyMessage);
        }
        return builder(transactions);
      case TransactionsStatus.initial:
        return const SizedBox.shrink();
    }
  }
}

class _TransactionsError extends StatelessWidget {
  const _TransactionsError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colors.errorContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No se pudo cargar la información',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(message.isEmpty ? 'Intenta nuevamente.' : message),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          )
        ],
      ),
    );
  }
}

class _TransactionsEmpty extends StatelessWidget {
  const _TransactionsEmpty({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long,
            size: 48,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
