import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';

class TransactionCategoryCardShared extends StatelessWidget {
  const TransactionCategoryCardShared({
    super.key,
    required this.transaction,
    this.onTap,
  });

  final TransactionEntity transaction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isExpense = transaction.type.isExpense;
    final amountText = formatCurrency(
      transaction.amount,
      includeSign: false,
    );
    final formattedAmount = isExpense ? '-$amountText' : '+$amountText';
    final categoryName = transaction.category?.name ?? 'Sin categoría';
    final subtitle = '$categoryName • ${formatShortDate(transaction.date)}';
    final icon =
        transaction.category?.icon ?? transaction.account?.icon ?? '💸';
    final accentColor = _parseColor(
      transaction.category?.color ?? transaction.account?.color,
    );

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: accentColor.withAlpha(38),
          child: Text(icon, style: const TextStyle(fontSize: 18)),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formattedAmount,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isExpense ? colors.error : colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              transaction.account?.name ?? 'Sin cuenta',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

Color _parseColor(String? value) {
  final fallback = Colors.grey.shade200;
  if (value == null || value.isEmpty) return fallback;
  final sanitized = value.replaceAll('#', '');
  final hex = int.tryParse(sanitized, radix: 16);
  if (hex == null) return fallback;
  if (sanitized.length <= 6) {
    return Color(0xFF000000 | hex);
  }
  return Color(hex);
}
