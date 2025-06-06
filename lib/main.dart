import 'package:flutter/material.dart';
import 'package:leave_management_app/routes/routes.dart';
// import 'package:leave_management_app/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Leave Management App',
    );
  }
  }
