import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class CardSymbolCategory extends StatelessWidget {
  const CardSymbolCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: colors.primary.withAlpha(20),
          borderRadius: BorderRadius.circular(
            AppDimensions.kBorderRadius6,
          ),
        ),
      ),
    );
  }
}
