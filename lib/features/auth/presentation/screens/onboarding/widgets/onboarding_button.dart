import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/shared.dart';
import '../../../provider/providers.dart';

class OnboardingButton extends ConsumerWidget {
  const OnboardingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingIndex = ref.watch(onboardingIndexProvider);
    final onboardingController = ref.watch(onboardingControllerProvider);
    final onboardingCompleted = ref.watch(onboardingCompletedProvider.notifier);

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
          onboardingCompleted.completeOnboarding();
          context.go('/register');
        }
      },
    );
  }
}
