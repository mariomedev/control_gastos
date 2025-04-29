import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../widgets/widgets.dart';

class RegisterBotton extends StatelessWidget {
  const RegisterBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonShare(
      title: 'Registrarse',
      onPressed: () {
        //TODO: Go to home. 
        context.go('/home');
      },
    );
  }
}
