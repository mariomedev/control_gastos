import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'route_paths.dart';
import '../../features/auth/presentation/screens/screens.dart';
import '../../features/home/presentation/screens/screens.dart';
import '../../features/shared/shared.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter routes = GoRouter(
  initialLocation: RoutePaths.splash,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePaths.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RoutePaths.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.categories,
      builder: (context, state) => const CategoriesScreen(),
      routes: [
        GoRoute(
          path: RoutePaths.createCategory,
          builder: (context, state) => const CreateCategoryScreen(),
        )
      ],
    ),
  ],
);
