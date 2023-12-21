import 'package:battleships/views/gameList.dart';
import 'package:battleships/views/registration.dart';
import 'package:flutter/material.dart';
import 'package:battleships/utils/http_service.dart';
import 'package:battleships/views/gameList.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  HttpService httpService = HttpService();

  void _login() async {
    int resp = await httpService.loginUser(_username, _password, context);
    print("helllooooooo");
    print(resp);
    if (resp == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameListPage(_username)),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return login();
  }

  Widget login() {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Add padding here
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                onSaved: (value) => _username = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => _password = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    _login();
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: _navigateToRegister,
                child: const Text('Register New Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
