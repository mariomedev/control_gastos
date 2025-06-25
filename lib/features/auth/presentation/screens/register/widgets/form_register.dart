import 'package:control_gastos/features/auth/presentation/provider/auth/register_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/core.dart';
import '../../../../../widgets/widgets.dart';

class FormRegister extends ConsumerWidget {
  const FormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formProvider = ref.watch(registerFormProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          _TitleForm(
            title: AppStrings.registerFormTitle1,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText1,
            onChanged: (value) {
              ref.read(registerFormProvider.notifier).onNameChanged(value);
            },
            errorText: formProvider.userNameInput.errorMessage,
          ),
          _TitleForm(
            title: AppStrings.registerFormTitle2,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText2,
          ),
          _TitleForm(
            title: AppStrings.registerFormTitle3,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText3,
            passwordIsActive: true,
          ),
          _TitleForm(
            title: AppStrings.registerFormTitle4,
          ),
          CustomForm(
            hintText: AppStrings.registerHintText4,
            passwordIsActive: true,
          ),
        ],
      ),
    );
  }
}

class _TitleForm extends StatelessWidget {
  final String title;
  const _TitleForm({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final textForm = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w700,
        );
    return Row(
      children: [
        Container(
          width: 5,
        ),
        Text(
          title,
          style: textForm,
        ),
      ],
    );
  }
}
