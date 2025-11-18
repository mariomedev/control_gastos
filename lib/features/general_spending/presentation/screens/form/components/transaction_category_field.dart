import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:control_gastos/core/core.dart';
import 'package:control_gastos/features/category/presentation/bloc/categories/categories_bloc.dart';
import 'package:control_gastos/features/general_spending/domain/domain.dart';

import 'inline_action_message.dart';

class TransactionCategoryField extends StatelessWidget {
  const TransactionCategoryField({
    super.key,
    required this.selectedType,
    required this.selectedCategoryId,
    required this.onChanged,
  });

  final TransactionType selectedType;
  final String? selectedCategoryId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        switch (state.status) {
          case CategoriesStatus.loading:
            return const LinearProgressIndicator();
          case CategoriesStatus.failure:
            return InlineActionMessage(
              message: state.errorMessage.isEmpty
                  ? 'No se pudieron cargar las categorías'
                  : state.errorMessage,
              actionLabel: 'Reintentar',
              onPressed: () => context
                  .read<CategoriesBloc>()
                  .add(const CategoriesFetchRequested()),
            );
          case CategoriesStatus.success:
            final filtered = state.categories
                .where(
                  (category) => selectedType.isExpense
                      ? category.isExpense
                      : category.isIncome,
                )
                .toList();
            if (filtered.isEmpty) {
              return InlineActionMessage(
                message: 'Aún no tienes categorías para este tipo.',
                actionLabel: 'Crear categoría',
                onPressed: () {
                  Navigator.of(context).maybePop();
                  context.push(RoutePaths.categories);
                },
              );
            }
            return DropdownButtonFormField<String?>(
              initialValue: selectedCategoryId,
              decoration: const InputDecoration(
                labelText: 'Categoría (opcional)',
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Sin categoría'),
                ),
                ...filtered.map(
                  (category) => DropdownMenuItem<String?>(
                    value: category.id,
                    child: Text(category.name),
                  ),
                ),
              ],
              onChanged: onChanged,
            );
          case CategoriesStatus.initial:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
