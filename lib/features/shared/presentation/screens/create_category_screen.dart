import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../shared.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appBarCreateCategory),
        centerTitle: true,
      ),
      body: Column(
        spacing: AppDimensions.kSpacing10,
        children: [
          CreateCategoryForm(),
          CategoryGridItem(),
          CustomButtonShare(
            title: AppStrings.buttonCreateCategory,
            onPressed: () {},
          ),
          SizedBox(height: AppDimensions.kMargin10)
        ],
      ),
    );
  }
}

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.kPadding20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimensions.kSpacing10,
        children: [
          Text(
            AppStrings.subTitleCreateCategory1,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          CustomForm(),
        ],
      ),
    );
  }
}

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
