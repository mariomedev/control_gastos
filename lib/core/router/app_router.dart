import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/screens.dart';
import '../../features/home/presentation/screens/screens.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    )
  ],
);
