import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';
import '../../../bloc/bloc.dart';

class LoginBottonBloc extends StatelessWidget {
  const LoginBottonBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormBloc, LoginFormState>(
      bloc: getIt<LoginFormBloc>(),
      listener: (context, state) {
        // Limpiar mensajes previos
        ScaffoldMessenger.of(context).clearSnackBars();

        if (state.isPosting) {
          // Mostrar loading mientras se realiza la petición
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Iniciando sesión...'),
              duration: Duration(seconds: 10),
            ),
          );
          return;
        }

        // Si el formulario fue enviado (isPosted) y no hay mensaje de error => éxito
        if (state.isPosted && state.errorMessage.isEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          context.go(RoutePaths.home);
          return;
        }

        // Si existe un mensaje de error mostrarlo
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
            onPressed: state.isValid && !state.isPosting
                ? () {
                    getIt<LoginFormBloc>().add(const LoginFormSubmitted());
                  }
                : null,
          );
        },
      ),
    );
  }
}
