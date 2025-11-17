import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';
import '../../../bloc/bloc.dart';

class RegisterBotton extends StatelessWidget {
  const RegisterBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      bloc: getIt<RegisterFormBloc>(),
      builder: (context, state) {
        return CustomButtonShare(
          title: 'Registrarse',
          onPressed: state.isValid && !state.isPosting
              ? () {
                  getIt<RegisterFormBloc>().add(RegisterFormSubmitted());
                }
              : null,
        );
      },
    );
  }
}
