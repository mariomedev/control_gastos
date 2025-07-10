import 'package:control_gastos/core/core.dart';

import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appBarCategories),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (categories.isEmpty) EmptyCategories(),
          if (categories.isNotEmpty) CategoryListBuilder(),
          AddCategoryButton(),
          SizedBox(height: AppDimensions.kMargin25)
        ],
      ),
    );
  }
}
