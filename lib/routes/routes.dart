

import 'package:go_router/go_router.dart';
import 'package:leave_management_app/screens/home_screen.dart';
import 'package:leave_management_app/screens/login_screen.dart';
import 'package:leave_management_app/screens/apply_leave_page.dart';

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
    GoRoute(
      path: '/apply-leave',
      builder: (context, state) => const LeaveApplicationHomePage(),
    ),
    // Add more routes here as needed
  ],
);
