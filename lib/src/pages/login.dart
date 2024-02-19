import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = 'admin';
    _passwordController.text = '1234';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(32),
              height: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ..._buildTextFields(),
                  SizedBox(height: 32),
                  ..._buildButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    print(
        'Login : with ${_usernameController.text},${_passwordController.text}');
  }

  _buildTextFields() {
    return [
      TextField(
          controller: _usernameController,
          decoration: InputDecoration(labelText: 'Username')),
      TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'))
    ];
  }

  void _handleRegister() {}

  _buildButtons() {
    return [
      ElevatedButton(onPressed: _handleLogin, child: Text('Login')),
      OutlinedButton(onPressed: _handleRegister, child: Text('Register'))
    ];
  }
}
