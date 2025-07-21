import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/shared.dart';
import '../../../provider/providers.dart';

class LoginBotton extends ConsumerWidget {
  const LoginBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authFormController = ref.watch(loginFormProvider.notifier);
    return CustomButtonShare(
      title: 'Iniciar Sesión',
      onPressed: () {
        authFormController.onFormSumit(context);
      },
    );
  }
}
