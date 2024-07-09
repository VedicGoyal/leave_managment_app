
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login/Sign-up',
          style: TextStyle(color: Colors.white),
          ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/lnm.png',
              width: 200,
              height: 200,
            ),
            const Text(
              'Leave Management',
              style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold),
              
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 1),
            ElevatedButton.icon(
              onPressed: () {
                // Placeholder for Google sign-in action
              },
              icon: const Icon(Icons.login),
              label: const Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Set background color
                foregroundColor: Colors.white, // Set text and icon color
                minimumSize: const Size(200, 50),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
