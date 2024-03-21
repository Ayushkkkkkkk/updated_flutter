import 'package:flutter/material.dart';
import 'package:test_flutter_login/login_page.dart';

// Import your LoginPage here
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        // Define your app's theme here
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Set your LoginPage as the home screen
    );
  }
}
