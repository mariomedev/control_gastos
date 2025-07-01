import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'widgets/widgets.dart';

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
          AddCategoryButton(),
          SizedBox(height: AppDimensions.kMargin10)
        ],
      ),
    );
  }
}
