import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          _TitleForm(
            title: AppStrings.loginFormTitle1,
          ),
          CustomForm(
            hintText: AppStrings.loginHintText1,
          ),
          _TitleForm(
            title: AppStrings.loginFormTitle2,
          ),
          CustomForm(
            hintText: AppStrings.loginHintText2,
            passwordIsActive: true,
          ),
        ],
      ),
    );
  }
}

class _TitleForm extends StatelessWidget {
  final String title;
  const _TitleForm({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final textForm = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w700,
        );
    return Row(
      children: [
        Container(
          width: 5,
        ),
        Text(
          title,
          style: textForm,
        ),
      ],
    );
  }
}
