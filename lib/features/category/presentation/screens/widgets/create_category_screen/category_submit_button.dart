import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:control_gastos/features/category/presentation/bloc/categories/categories_bloc.dart';

class CategorySubmitButton extends StatelessWidget {
  const CategorySubmitButton({
    super.key,
    required this.isEditing,
    required this.onSubmit,
    required this.createLabel,
  });

  final bool isEditing;
  final VoidCallback onSubmit;
  final String createLabel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      buildWhen: (previous, current) =>
          previous.mutationStatus != current.mutationStatus,
      builder: (context, state) {
        final isSubmitting =
            state.mutationStatus == CategoriesMutationStatus.submitting;
        return FilledButton(
          onPressed: isSubmitting ? null : onSubmit,
          child: isSubmitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEditing ? 'Guardar cambios' : createLabel),
        );
      },
    );
  }
}
