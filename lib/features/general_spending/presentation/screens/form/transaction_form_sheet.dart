import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:control_gastos/core/core.dart';
import 'package:control_gastos/features/accounts/accounts_feature.dart';
import 'package:control_gastos/features/category/presentation/bloc/categories/categories_bloc.dart';
import 'package:control_gastos/features/general_spending/domain/domain.dart';
import 'package:control_gastos/features/general_spending/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:control_gastos/features/general_spending/presentation/screens/form/components/transaction_form_sheet.dart';

Future<void> showTransactionFormSheet(
  BuildContext context, {
  required TransactionType initialType,
  TransactionEntity? initialTransaction,
}) {
  final transactionsBloc = context.read<TransactionsBloc>();
  final accountsBloc = getIt<AccountsBloc>();
  final categoriesBloc = getIt<CategoriesBloc>();

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: transactionsBloc),
          BlocProvider.value(value: accountsBloc),
          BlocProvider.value(value: categoriesBloc),
        ],
        child: TransactionFormSheet(
          initialType: initialType,
          initialTransaction: initialTransaction,
        ),
      );
    },
  );
}
