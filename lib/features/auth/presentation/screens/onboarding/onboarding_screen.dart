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
            bottom: 50,
            child: OnboardingButton(),
          ),
        ],
      ),
    );
  }
}

