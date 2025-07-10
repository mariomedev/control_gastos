import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';

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
