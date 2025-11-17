import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';
import '../../../bloc/bloc.dart';

class LoginBotton extends StatelessWidget {
  const LoginBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormBloc, LoginFormState>(
      bloc: getIt<LoginFormBloc>(),
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();

        if (state.isPosting) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Iniciando sesión...'),
              duration: Duration(seconds: 10),
            ),
          );
          return;
        }

        if (state.isPosted && state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginFormBloc, LoginFormState>(
        bloc: getIt<LoginFormBloc>(),
        builder: (context, state) {
          return CustomButtonShare(
            title: 'Iniciar Sesión',
            onPressed: () {
              getIt<LoginFormBloc>().add(const LoginFormSubmitted());
            },
          );
        },
      ),
    );
  }
}
