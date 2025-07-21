import 'package:control_gastos/features/auth/presentation/provider/providers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationScale;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );
    _animationScale = Tween<double>(begin: 0.1, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    ));

    _animationController.forward().whenComplete(() async {
      final onboardingCompleted = await ref
          .read(onboardingCompletedProvider.notifier)
          .checkOnboardingStatus();
      if (!mounted) return;
      context.go(onboardingCompleted ? '/register' : '/onboarding');
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.primary,
      body: Center(
        child: ScaleTransition(
          scale: _animationScale,
          child: Image.asset(
            AppAssets.splashImage,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
