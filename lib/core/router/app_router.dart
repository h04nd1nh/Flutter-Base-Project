import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/user/presentation/pages/home_page.dart';
import '../../features/user/presentation/pages/profile_page.dart';

class AppRouter {
  static const String home = '/';
  static const String profile = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: const Center(child: Text('Page not found'))),
  );
}
