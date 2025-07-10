import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonShare(
      title: AppStrings.addButtonCategory,
      onPressed: () => context.push('/categories/create_category'),
    );
  }
}
