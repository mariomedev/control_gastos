import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../widgets.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.kPadding20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.kSpacing10,
          children: [
            Text(
              AppStrings.subTitleCreateCategory2,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 51,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return CardSymbolCategory();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
