import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';

class CategoryTypeSelector extends StatelessWidget {
  const CategoryTypeSelector({
    super.key,
    required this.selectedType,
    required this.isEditing,
    required this.onChanged,
  });

  final CategoryType selectedType;
  final bool isEditing;
  final ValueChanged<CategoryType>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tipo', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        SegmentedButton<CategoryType>(
          segments: const [
            ButtonSegment(
              value: CategoryType.expense,
              label: Text('Gasto'),
              icon: Icon(Icons.south_east),
            ),
            ButtonSegment(
              value: CategoryType.income,
              label: Text('Ingreso'),
              icon: Icon(Icons.north_east),
            ),
          ],
          selected: <CategoryType>{selectedType},
          onSelectionChanged: isEditing || onChanged == null
              ? null
              : (selection) => onChanged!(selection.first),
        ),
        if (isEditing)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              'No puedes cambiar el tipo de una categoría existente.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).hintColor),
            ),
          ),
      ],
    );
  }
}
