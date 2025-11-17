import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        if (state.isPosting) {
          // Mostrar loading
        }
        // Aquí puedes escuchar cambios de estado y navegar o mostrar errores
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
