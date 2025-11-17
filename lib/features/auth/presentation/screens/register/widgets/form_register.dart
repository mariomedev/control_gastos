import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';
import '../../../bloc/bloc.dart';

class FormRegister extends StatelessWidget {
  const FormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      bloc: getIt<RegisterFormBloc>(),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              const _TitleForm(
                title: AppStrings.registerFormTitle1,
              ),
              CustomForm(
                hintText: AppStrings.registerHintText1,
                onChanged: (value) =>
                    getIt<RegisterFormBloc>().add(RegisterNameChanged(value)),
                errorText:
                    state.isPosted ? state.userNameInput.errorMessage : null,
              ),
              const _TitleForm(
                title: AppStrings.registerFormTitle2,
              ),
              CustomForm(
                hintText: AppStrings.registerHintText2,
                onChanged: (value) =>
                    getIt<RegisterFormBloc>().add(RegisterEmailChanged(value)),
                errorText:
                    state.isPosted ? state.emailInput.errorMessage : null,
              ),
              const _TitleForm(
                title: AppStrings.registerFormTitle3,
              ),
              CustomForm(
                hintText: AppStrings.registerHintText3,
                passwordIsActive: true,
                onChanged: (value) => getIt<RegisterFormBloc>()
                    .add(RegisterPasswordChanged(value)),
                errorText:
                    state.isPosted ? state.passwordInput.errorMessage : null,
              ),
              const _TitleForm(
                title: AppStrings.registerFormTitle4,
              ),
              CustomForm(
                hintText: AppStrings.registerHintText4,
                passwordIsActive: true,
                onChanged: (value) => getIt<RegisterFormBloc>()
                    .add(RegisterConfirmPasswordChanged(value)),
                errorText: state.isPosted
                    ? state.confirmPasswordInput.errorMessage
                    : null,
              ),
            ],
          ),
        );
      },
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
