import 'package:control_gastos/features/shared/domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class CardCategory extends StatelessWidget {
  final CategoryEntity category;
  const CardCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = colors.brightness == Brightness.dark ? true : false;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.kPadding20,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: AppDimensions.kMargin10),
        color: isDark ? colors.onPrimaryContainer : null,
        child: ListTile(
          title: Text(category.title),
          leading: Icon(Icons.price_change),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_forever_outlined,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
