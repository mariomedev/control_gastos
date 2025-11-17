import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../bloc/bloc.dart';
import 'widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterFormBloc, RegisterFormState>(
      bloc: getIt<RegisterFormBloc>(),
      listener: (context, state) {
        if (!state.isPosting && state.isPosted) {
          // Aquí puedes mostrar snackbars o navegar si el registro fue exitoso
          if (state.isValid) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registro exitoso'),
              ),
            );
            context.pushNamed(RoutePaths.login);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
          elevation: 1,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              _SpacerForm(0.07),
              FormRegister(),
              _SpacerForm(0.1),
              RegisterBotton(),
              _SpacerForm(0.1),
              RegisterSocialMedia()
            ],
          ),
        ),
      ),
    );
  }
}

class _SpacerForm extends StatelessWidget {
  final double value;
  const _SpacerForm(
    this.value,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenHelper.responsiveHeight(
        context,
        value,
      ),
    );
  }
}
