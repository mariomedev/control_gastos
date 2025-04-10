import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../widgets/widgets.dart';

class LoginBotton extends StatelessWidget {
  const LoginBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottonShare(
      title: 'Iniciar Sesión',
      onPressed: () {
        //TODO: Go to View General.
        context.go('/home');
      },
    );
  }
}
