import 'package:control_gastos/features/auth/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => OnboardingScreen(),
    )
  ],
);
