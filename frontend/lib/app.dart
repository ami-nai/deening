import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/prayers/ui/screens/fazr_screen.dart';
import 'package:frontend/features/prayers/ui/screens/zuhr_screen.dart';
import 'package:frontend/features/prayers/ui/screens/asr_screen.dart';
import 'package:frontend/features/prayers/ui/screens/maghrib_screen.dart';
import 'package:frontend/features/prayers/ui/screens/isha_screen.dart';
import 'package:go_router/go_router.dart';
import 'core/router/app_router.dart';
import 'core/storage/secure_storage.dart';
import 'features/auth/ui/screens/login_screen.dart';
import 'features/auth/ui/screens/register_screen.dart';
import 'features/auth/ui/screens/onboarding_screen.dart';
import 'features/auth/ui/screens/recover_screen.dart';
import 'features/prayers/ui/screens/home_screen.dart';
import 'features/prayers/ui/screens/prayer_grid_screen.dart';
import 'features/stats/ui/screens/stats_screen.dart';
import 'shared/theme/app_theme.dart';

class App extends ConsumerWidget {
  final SecureStorage secureStorage;

  const App({required this.secureStorage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Prayer Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _createRouter(secureStorage),
      debugShowCheckedModeBanner: false,
    );
  }

  GoRouter _createRouter(SecureStorage storage) {
    return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) async {
        final hasToken = await storage.hasAccessToken();

        // If trying to access auth routes with token, go to home
        if (hasToken &&
            (state.matchedLocation == '/login' ||
                state.matchedLocation == '/register')) {
          return '/home';
        }

        // If no token and trying to access protected routes, go to login
        if (!hasToken &&
            state.matchedLocation != '/login' &&
            state.matchedLocation != '/register' &&
            state.matchedLocation != '/onboarding') {
          return '/login';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/recover',
          name: 'recover',
          builder: (context, state) => const RecoverScreen(),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/prayers',
          name: 'prayers',
          builder: (context, state) => const PrayerGridScreen(),
        ),
        GoRoute(
          path: '/fazr',
          name: 'fazr',
          builder: (context, state) => const FazrScreen()),
        GoRoute(
          path: '/zuhr',
          name: 'zuhr',
          builder: (context, state) => const ZuhrScreen()),
        GoRoute(
          path: '/asr',
          name: 'asr',
          builder: (context, state) => const AsrScreen()),
        GoRoute(
          path: '/maghrib',
          name: 'maghrib',
          builder: (context, state) => const MaghribScreen()),
        GoRoute(
          path: '/isha',
          name: 'isha',
          builder: (context, state) => const IshaScreen()),
        GoRoute(
          path: '/stats',
          name: 'stats',
          builder: (context, state) => const StatsScreen(),
        ),
      ],
    );
  }
}
