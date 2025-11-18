import 'package:flutter/material.dart';

import 'package:control_gastos/features/general_spending/domain/domain.dart';

class TransactionTypeSelector extends StatelessWidget {
  const TransactionTypeSelector({
    super.key,
    required this.selectedType,
    required this.allowTypeChange,
    required this.showTypeIcon,
    required this.onChanged,
  });

  final TransactionType selectedType;
  final bool allowTypeChange;
  final bool showTypeIcon;
  final ValueChanged<TransactionType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SegmentedButton<TransactionType>(
            segments: const [
              ButtonSegment(
                value: TransactionType.expense,
                label: Text('Gasto'),
              ),
              ButtonSegment(
                value: TransactionType.income,
                label: Text('Ingreso'),
              ),
            ],
            selected: {selectedType},
            onSelectionChanged: allowTypeChange
                ? (selection) => onChanged(selection.first)
                : null,
          ),
        ),
        if (showTypeIcon)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(
              selectedType.isExpense ? Icons.remove_circle : Icons.add_circle,
              color: selectedType.isExpense
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
      ],
    );
  }
}
