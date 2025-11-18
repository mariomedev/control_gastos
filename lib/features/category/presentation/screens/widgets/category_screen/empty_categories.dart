import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class EmptyCategories extends StatelessWidget {
  const EmptyCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 52,
            color: colors.primary,
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.emptyCategories,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
