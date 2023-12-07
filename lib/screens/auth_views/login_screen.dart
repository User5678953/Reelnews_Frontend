import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reel_news/screens/api_news_screen.dart';
import 'dart:convert';
//import '../../widgets/auth_token_widget.dart';
import 'register_screen.dart'; 

class LoginScreen extends StatefulWidget {
  final String? initialUsername;
  final String? initialPassword;

  LoginScreen({this.initialUsername, this.initialPassword});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.initialUsername);
    passwordController = TextEditingController(text: widget.initialPassword);
  }

  Future<void> performLogin() async {
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse(
            'https://reelnews-api-fe5e8d8c10e8.herokuapp.com/auth/login/'),
        headers: {'Content-Type': 'application/json'},
       body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['access'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => APINewsScreen()),
        );
      } else {
        // This block is executed when login fails
        String errorMessage = "Couldn't login. Check username and password.";
        if (response.body.isNotEmpty) {
          final responseData = json.decode(response.body);
          if (responseData['message'] != null) {
            errorMessage = responseData[
                'message']; 
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reel News')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                icon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: performLogin,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
