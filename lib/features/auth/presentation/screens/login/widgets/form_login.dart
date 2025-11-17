import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';
import '../../../bloc/bloc.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      bloc: GetIt.instance<LoginFormBloc>(),
      builder: (context, authFormState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              const _TitleForm(
                title: AppStrings.loginFormTitle1,
              ),
              CustomForm(
                hintText: AppStrings.loginHintText1,
                onChanged: (value) => GetIt.instance<LoginFormBloc>()
                    .add(LoginEmailChanged(value)),
                keyboardType: TextInputType.emailAddress,
                errorText: authFormState.isPosted
                    ? authFormState.emailInput.errorMessage
                    : null,
              ),
              const _TitleForm(
                title: AppStrings.loginFormTitle2,
              ),
              CustomForm(
                hintText: AppStrings.loginHintText2,
                passwordIsActive: true,
                onChanged: (value) => GetIt.instance<LoginFormBloc>()
                    .add(LoginPasswordChanged(value)),
                errorText: authFormState.isPosted
                    ? authFormState.passwordInput.errorMessage
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
