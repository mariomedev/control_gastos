import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';
import '../../../provider/providers.dart';

class FormRegister extends ConsumerWidget {
  const FormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(registerFormProvider);
    final formController = ref.read(registerFormProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          _TitleForm(
            title: AppStrings.registerFormTitle1,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText1,
            onChanged: (value) => formController.onNameChanged(value),
            errorText: formState.userNameInput.errorMessage,
          ),
          _TitleForm(
            title: AppStrings.registerFormTitle2,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText2,
          ),
          _TitleForm(
            title: AppStrings.registerFormTitle3,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText3,
            passwordIsActive: true,
          ),
          _TitleForm(
            title: AppStrings.registerFormTitle4,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText4,
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
    final textFormStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w700,
        );
    return Row(
      children: [
        Container(
          width: 5,
        ),
        Text(
          title,
          style: textFormStyle,
        ),
      ],
    );
  }
}
