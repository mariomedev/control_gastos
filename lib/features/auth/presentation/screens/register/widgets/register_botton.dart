import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/shared.dart';
import '../../../bloc/bloc.dart';

class RegisterBotton extends StatelessWidget {
  const RegisterBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonShare(
        title: 'Registrarse',
        onPressed: () {
          getIt<RegisterFormBloc>().add(const RegisterFormSubmitted());
        });
  }
}
