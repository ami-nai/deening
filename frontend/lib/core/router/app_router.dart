import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../storage/secure_storage.dart';

class AppRouter {
  static GoRouter createRouter(SecureStorage secureStorage) {
    return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) async {
        final hasToken = await secureStorage.hasAccessToken();

        // If trying to access auth routes with token, go to home
        if (hasToken && (state.matchedLocation == '/login' || state.matchedLocation == '/register')) {
          return '/home';
        }

        // If no token and trying to access protected routes, go to login
        if (!hasToken && state.matchedLocation != '/login' && state.matchedLocation != '/register' && state.matchedLocation != '/onboarding') {
          return '/login';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) => const SizedBox.expand(
            child: Placeholder(),
          ),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const SizedBox.expand(
            child: Placeholder(),
          ),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const SizedBox.expand(
            child: Placeholder(),
          ),
        ),
        GoRoute(
          path: '/recover',
          name: 'recover',
          builder: (context, state) => const SizedBox.expand(
            child: Placeholder(),
          ),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const SizedBox.expand(
            child: Placeholder(),
          ),
        ),
        GoRoute(
          path: '/prayers',
          name: 'prayers',
          builder: (context, state) => const SizedBox.expand(
            child: Placeholder(),
          ),
        ),
        GoRoute(
          path: '/stats',
          name: 'stats',
          builder: (context, state) => const SizedBox.expand(
            child: Placeholder(),
          ),
        ),
      ],
    );
  }
}
