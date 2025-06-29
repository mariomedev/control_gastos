import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/shared.dart';

class RegisterBotton extends StatelessWidget {
  const RegisterBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonShare(
      title: 'Registrarse',
      onPressed: () {
        context.go('/home');
      },
    );
  }
}
