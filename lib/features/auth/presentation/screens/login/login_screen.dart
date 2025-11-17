import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import 'widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        centerTitle: true,
        elevation: 1,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            _SpacerForm(0.07),
            FormLogin(),
            _SpacerForm(0.1),
            LoginBotton(),
            _SpacerForm(0.1),
            LoginSocialMedia()
          ],
        ),
      ),
    );
  }
}

class _SpacerForm extends StatelessWidget {
  final double value;
  const _SpacerForm(
    this.value,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenHelper.responsiveHeight(
        context,
        value,
      ),
    );
  }
}
