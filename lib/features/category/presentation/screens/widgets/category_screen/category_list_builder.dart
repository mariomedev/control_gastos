import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import 'card_category.dart';

class CategoryListBuilder extends StatelessWidget {
  const CategoryListBuilder({
    super.key,
    required this.categories,
    this.onEdit,
    this.onDelete,
  });

  final List<CategoryEntity> categories;
  final ValueChanged<CategoryEntity>? onEdit;
  final ValueChanged<CategoryEntity>? onDelete;

  @override
  Widget build(BuildContext context) {
    final expenseCategories = categories
        .where((category) => category.isExpense)
        .toList(growable: false);
    final incomeCategories = categories
        .where((category) => category.isIncome)
        .toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (expenseCategories.isNotEmpty)
          _CategorySection(
            title: 'Categorías de gastos',
            categories: expenseCategories,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        if (incomeCategories.isNotEmpty)
          _CategorySection(
            title: 'Categorías de ingresos',
            categories: incomeCategories,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
      ],
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.title,
    required this.categories,
    this.onEdit,
    this.onDelete,
  });

  final String title;
  final List<CategoryEntity> categories;
  final ValueChanged<CategoryEntity>? onEdit;
  final ValueChanged<CategoryEntity>? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        ...categories.map(
          (category) => CardCategory(
            category: category,
            onEdit: onEdit == null ? null : () => onEdit!(category),
            onDelete: onDelete == null ? null : () => onDelete!(category),
          ),
        ),
      ],
    );
  }
}
