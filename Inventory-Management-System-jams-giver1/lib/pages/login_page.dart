import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User registered successfully'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to register user'),
      ));
    }
  }

  Future<void> login(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final token = data['token'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login successful'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid username or password'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Image(
                  image: AssetImage('assets/icons/traffic-logo.png'),
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => login(context),
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.95, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => register(context),
                child: const Text('Register'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.95, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
