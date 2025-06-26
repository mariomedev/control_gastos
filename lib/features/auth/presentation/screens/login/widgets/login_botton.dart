import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets.dart';

class LoginBotton extends StatelessWidget {
  const LoginBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonShare(
      title: 'Iniciar Sesión',
      onPressed: () {
        context.go('/home');
      },
    );
  }
}
