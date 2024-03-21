import 'package:flutter/material.dart';
import 'commute_page1.dart'; // Import your CommutePage1 here

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CommutePage1(), // Set your CommutePage1 as the home screen
    );
  }
}
