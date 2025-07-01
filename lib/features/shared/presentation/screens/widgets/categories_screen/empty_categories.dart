import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class EmptyCategories extends StatelessWidget {
  const EmptyCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.emptyCategories,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Icon(
              Icons.add_a_photo_outlined,
              size: 50,
              color: colors.primary,
            )
          ],
        ),
      ),
    );
  }
}
