import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets.dart';
import '../../../provider/providers.dart';

class OnboardingButton extends ConsumerWidget {
  const OnboardingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingIndex = ref.watch(onboardingIndexProvider);
    final onboardingController = ref.watch(onboardingControllerProvider);

    return CustomButtonShare(
      title: (onboardingIndex == 2) ? 'Siguiente' : 'Empezar',
      onPressed: () {
        if (onboardingIndex != 2) {
          onboardingController!.nextPage(
            duration: Duration(seconds: 1),
            curve: Curves.easeOutCubic,
          );
        }
        if (onboardingIndex == 2) {
          context.go('/register');
        }
      },
    );
  }
}
