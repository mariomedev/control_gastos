import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';
import '../../../provider/providers.dart';

class FormLogin extends ConsumerWidget {
  const FormLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authFormController = ref.watch(loginFormProvider.notifier);
    final authFormState = ref.watch(loginFormProvider);
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
            onChanged: (value) => authFormController.onEmailChanged(value),
            keyboardType: TextInputType.emailAddress,
            errorText: authFormState.isPosted
                ? authFormState.emailInput.errorMessage
                : null,
          ),
          _TitleForm(
            title: AppStrings.loginFormTitle2,
          ),
          CustomForm(
            hintText: AppStrings.loginHintText2,
            passwordIsActive: true,
            onChanged: (value) => authFormController.onPasswordChanged(value),
            errorText: authFormState.isPosted
                ? authFormState.passwordInput.errorMessage
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
