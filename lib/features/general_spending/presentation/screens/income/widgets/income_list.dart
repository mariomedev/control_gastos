import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../shared/shared.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({
    super.key,
    required this.transactions,
    this.onTransactionTap,
  });

  final List<TransactionEntity> transactions;
  final ValueChanged<TransactionEntity>? onTransactionTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionCategoryCardShared(
          transaction: transaction,
          onTap: onTransactionTap == null
              ? null
              : () => onTransactionTap!(transaction),
        );
      },
    );
  }
}
