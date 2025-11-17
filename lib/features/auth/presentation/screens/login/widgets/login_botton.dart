import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../shared/shared.dart';
import '../../../bloc/bloc.dart';

class LoginBotton extends StatelessWidget {
  const LoginBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      bloc: GetIt.instance<LoginFormBloc>(),
      builder: (context, authFormState) {
        return CustomButtonShare(
          title: 'Iniciar Sesión',
          onPressed: authFormState.isValid && !authFormState.isPosting
              ? () {
                  GetIt.instance<LoginFormBloc>()
                      .add(const LoginFormSubmitted());
                }
              : null,
        );
      },
    );
  }
}
