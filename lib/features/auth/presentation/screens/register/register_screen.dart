import 'package:control_gastos/features/auth/presentation/screens/register/widgets/register_social_media.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import 'widgets/form_register.dart';
import 'widgets/register_botton.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _SpacerForm(0.07),
            FormRegister(),
            _SpacerForm(0.1),
            RegisterBotton(),
            _SpacerForm(0.1),
            RegisterSocialMedia()
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
