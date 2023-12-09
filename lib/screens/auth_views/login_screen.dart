import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reel_news/screens/public_news_screen.dart';
import 'register_screen.dart';
import 'dart:convert';

//import '../../widgets/auth_token_widget.dart';
//import 'package:reel_news/screens/api_news_screen.dart';

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
          MaterialPageRoute(builder: (context) => PublicNewsScreen()),
        );
      } else {
        // This block is executed when login fails
        String errorMessage = "Couldn't login. Check username and password.";
        if (response.body.isNotEmpty) {
          final responseData = json.decode(response.body);
          if (responseData['message'] != null) {
            errorMessage = responseData['message'];
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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 16, 16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Reel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.yellow)),
            Text('News',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
          ],
        ),
        elevation: 4.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold, 
              ),
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                icon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
              ),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold, 
              ),
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                icon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: performLogin,
              child:
                  Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: Text('Don\'t have an account? Register here',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, 
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
