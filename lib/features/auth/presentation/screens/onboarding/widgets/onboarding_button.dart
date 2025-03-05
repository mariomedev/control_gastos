import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/core.dart';
import '../../../provider/providers.dart';

class OnboardingButton extends ConsumerWidget {
  const OnboardingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingIndex = ref.watch(onboardingIndexProvider);
    final onboardingController = ref.watch(onboardingControllerProvider);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenHelper.responsiveWidth(context, 0.1),
      ),
      child: SizedBox(
        width: ScreenHelper.responsiveWidth(context, 0.8),
        height: 55,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Color(0xFF3366FF)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          child: Text(
            (onboardingIndex == 2) ? 'Siguiente' : 'Empezar',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            if (onboardingIndex != 2) {
              onboardingController!.nextPage(
                duration: Duration(seconds: 1),
                curve: Curves.easeOutCubic,
              );
            }
            if (onboardingIndex == 2) {
              
            }
          },
        ),
      ),
    );
  }
}
