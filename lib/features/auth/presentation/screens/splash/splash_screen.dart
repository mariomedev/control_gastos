import 'package:control_gastos/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );
    _animationScale = Tween<double>(begin: 0.1, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    ));

    _animationController.forward().whenComplete(() {
      context.push('/onboarding');
    });

    super.initState();
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
