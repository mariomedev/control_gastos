import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';

class NewCategoryButton extends StatelessWidget {
  const NewCategoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonShare(
      title: AppStrings.buttonCreateCategory,
      onPressed: () {},
    );
  }
}
