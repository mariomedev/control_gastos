import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/screens.dart';
import '../../features/home/presentation/screens/screens.dart';
import '../../features/shared/shared.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
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
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => CategoriesScreen(),
      routes: [
        GoRoute(
          path: '/create_category',
          builder: (context, state) => CreateCategoryScreen(),
        )
      ],
    ),
  ],
);
