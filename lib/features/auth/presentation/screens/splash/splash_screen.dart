import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../bloc/bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationScale;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _animationScale = Tween<double>(begin: 0.1, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    ));

    _animationController.forward().whenComplete(() {
      if (!mounted) return;
      GetIt.instance<OnboardingBloc>().add(const CheckOnboardingStatus());
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
    return BlocListener<OnboardingBloc, OnboardingState>(
      bloc: GetIt.instance<OnboardingBloc>(),
      listener: (context, state) {
        if (!state.isLoading) {
          context.go(state.isCompleted ? '/login' : '/onboarding');
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
