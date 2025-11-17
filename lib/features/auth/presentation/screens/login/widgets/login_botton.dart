import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../shared/shared.dart';
import '../../../bloc/bloc.dart';

class LoginBotton extends StatelessWidget {
  const LoginBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonShare(
      title: 'Iniciar Sesión',
      onPressed: () {
        GetIt.instance<LoginFormBloc>().add(const LoginFormSubmitted());
      },
    );
  }
}
