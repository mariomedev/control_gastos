import 'package:control_gastos/core/core.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          OnboardingPageView(),
          Positioned(
            bottom: ScreenHelper.responsiveHeight(context, 0.05),
            child: OnboardingButton(),
          ),
          Positioned(
            bottom: ScreenHelper.responsiveHeight(context, 0.25),
            child: Dots(),
          ),
        ],
      ),
    );
  }
}

