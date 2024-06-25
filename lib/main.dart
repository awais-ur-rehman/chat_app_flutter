import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'welcome_screen.dart';
import 'chat_screen.dart';
import 'list_screen.dart';
import 'extension.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User & Fixer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
      routes: {
        '/signup': (context) => SignupScreen(onSignup: () {
          Navigator.pushReplacementNamed(context, '/login');
        }),
        '/login': (context) => LoginScreen(onLogin: (role, user) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ListScreen(
                role: role,
                user: user,
              ),
            ),
          );
        }),
        '/chat': (context) => ChatScreen(
          role: 'user', // Replace with actual role logic
          userName: 'User', // Replace with actual user name logic
          chatPartnerName: 'Partner', // Replace with actual chat partner name logic
        ),
        '/list': (context) => ListScreen(
          role: 'user', // Replace with actual role logic
          user: {'name': 'User'}, // Replace with actual user name logic
        ),
      },
    );
  }
}
