import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/transactions/transactions_bloc.dart';
import '../form/transaction_form_sheet.dart';
import '../shared/shared.dart';
import '../../../domain/domain.dart';
import 'widgets/widgets.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        final incomes = state.transactions
            .where((transaction) => transaction.type.isIncome)
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
              IncomeGraph(
                totalIncome: state.totalIncome,
                totalExpense: state.totalExpense,
                balance: state.balance,
              ),
              IncomeButtonAdd(
                onPressed: () => showTransactionFormSheet(
                  context,
                  initialType: TransactionType.income,
                ),
              ),
              const SizedBox(height: 16),
              TransactionsSection(
                state: state,
                transactions: incomes,
                emptyMessage: 'Aún no registras ingresos.',
                onRetry: () => context
                    .read<TransactionsBloc>()
                    .add(const TransactionsFetchRequested()),
                builder: (items) => IncomeList(
                  transactions: items,
                  onTransactionTap: (transaction) => showTransactionFormSheet(
                    context,
                    initialType: transaction.type,
                    initialTransaction: transaction,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
