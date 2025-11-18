import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/transactions/transactions_bloc.dart';
import '../form/transaction_form_sheet.dart';
import '../shared/shared.dart';
import '../../../domain/domain.dart';
import 'widgets/widgets.dart';

class SpentScreen extends StatelessWidget {
  const SpentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        final expenses = state.transactions
            .where((transaction) => transaction.type.isExpense)
            .toList();
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<TransactionsBloc>()
                .add(const TransactionsRefreshRequested());
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SpentGraph(
                totalExpense: state.totalExpense,
                totalIncome: state.totalIncome,
                balance: state.balance,
              ),
              SpentButtonAdd(
                onPressed: () => showTransactionFormSheet(
                  context,
                  initialType: TransactionType.expense,
                ),
              ),
              const SizedBox(height: 16),
              TransactionsSection(
                state: state,
                transactions: expenses,
                emptyMessage: 'Aún no registras gastos.',
                onRetry: () => context
                    .read<TransactionsBloc>()
                    .add(const TransactionsFetchRequested()),
                builder: (items) => SpentList(
                  transactions: items,
                  onTransactionTap: (transaction) => showTransactionFormSheet(
                    context,
                    initialType: transaction.type,
                    initialTransaction: transaction,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
