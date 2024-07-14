

import 'package:go_router/go_router.dart';
import 'package:leave_management_app/screens/home_screen.dart';
import 'package:leave_management_app/screens/login_screen.dart';

final router = GoRouter(
  routes: [

    // Something related to route protection
    // Auth-Guard: Authentication --> routes 
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Add more routes here as needed
  ],
);
