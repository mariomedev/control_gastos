import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/shared.dart';
import '../../../provider/providers.dart';

class RegisterBotton extends ConsumerWidget {
  const RegisterBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authFormController = ref.watch(registerFormProvider.notifier);
    return CustomButtonShare(
      title: 'Registrarse',
      onPressed: () {
        authFormController.onFormSumit(context);
      },
    );
  }
}
