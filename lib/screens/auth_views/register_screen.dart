import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> performRegistration() async {
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse(
            'https://reelnews-api-fe5e8d8c10e8.herokuapp.com/auth/register/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              initialUsername: usernameController.text,
              initialPassword: passwordController.text,
            ),
          ),
        );
      } else {
        final responseData = json.decode(response.body);
        final errorMessage = responseData['message'];
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
          content: Text(
              'Oops! Registration error: Sorry, this User already exists // for Developers: $e'),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
           color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
      ),

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
                labelStyle: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
              style: TextStyle(
                color: Colors.white, 
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16),

            // password field
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                icon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(
                color: Colors.white, 
              ),
              obscureText: true,
            ),


            SizedBox(height: 24),
            ElevatedButton(
              onPressed: performRegistration,
              child: Text('Register',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
