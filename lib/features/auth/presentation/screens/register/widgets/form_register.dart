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
    final authFormController = ref.read(registerFormProvider.notifier);
    final authFormState = ref.watch(registerFormProvider);
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
            onChanged: (value) => authFormController.onNameChanged(value),
            errorText: authFormState.isPosted
                ? authFormState.userNameInput.errorMessage
                : null,
          ),
          _TitleForm(
            title: AppStrings.registerFormTitle2,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText2,
            onChanged: (value) => authFormController.onEmailChanged(value),
            errorText: authFormState.isPosted
                ? authFormState.emailInput.errorMessage
                : null,
          ),
          _TitleForm(
            title: AppStrings.registerFormTitle3,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText3,
            passwordIsActive: true,
            onChanged: (value) => authFormController.onPasswordChanged(value),
            errorText: authFormState.isPosted
                ? authFormState.passwordInput.errorMessage
                : null,
          ),
          _TitleForm(
            title: AppStrings.registerFormTitle4,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText4,
            passwordIsActive: true,
            onChanged: (value) =>
                authFormController.onConfirmPasswordChanged(value),
            errorText: authFormState.isPosted
                ? authFormState.confirmPasswordInput.errorMessage
                : null,
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
