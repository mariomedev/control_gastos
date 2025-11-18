import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import '../../../../domain/domain.dart';

class SpentList extends StatelessWidget {
  const SpentList({
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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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
