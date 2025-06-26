import 'package:flutter/material.dart';

class TransactionCategoryCardShared extends StatelessWidget {
  const TransactionCategoryCardShared({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      elevation: 5,
      color: colors.onPrimaryContainer,
      child: ListTile(
        title: Text(
          'Gasto',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(Icons.check_circle_outline),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$S10',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '%',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
