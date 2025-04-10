import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../widgets/widgets.dart';

class FormRegister extends StatelessWidget {
  const FormRegister({
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
            title: TextImages.registerFormTitle1,
          ),
          CustomForm(
            hintText: TextImages.registerHintText1,
          ),
          _TitleForm(
            title: TextImages.registerFormTitle2,
          ),
          CustomForm(
            hintText: TextImages.registerHintText2,
            passwordIsActive: true,
          ),
          _TitleForm(
            title: TextImages.registerFormTitle3,
          ),
          CustomForm(
            hintText: TextImages.registerHintText3,
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

