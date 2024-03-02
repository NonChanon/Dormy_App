import 'package:dorm_app/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formfield = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPwdController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset('assets/image/logo_white.png', width: 300),
                ..._buildTextFields(),
                SizedBox(height: 20),
                ..._buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    print('Login : with ${_emailController.text},${_passwordController.text}');
  }

  _buildTextFields() {
    return [
      TextFormField(
        keyboardType: TextInputType.name,
        controller: _firstnameController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
          hintText: 'Firstname',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person, color: Colors.black),
        ),
        validator: (value) {
          bool nameValid = RegExp(r"^[a-zA-Z]").hasMatch(value!);
          if (value.isEmpty) {
            return "Enter Firstname";
          } else if (!nameValid) {
            return "Enter Valid Firstname";
          }
        },
      ),
      SizedBox(
        height: 20,
      ),
      TextFormField(
        keyboardType: TextInputType.name,
        controller: _lastnameController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
          hintText: 'Lastname',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person, color: Colors.black),
        ),
        validator: (value) {
          bool lastnameValid = RegExp(r"^[a-zA-Z]").hasMatch(value!);
          if (value.isEmpty) {
            return "Enter Lastname";
          } else if (!lastnameValid) {
            return "Enter Valid Lastname";
          }
        },
      ),
      SizedBox(
        height: 20,
      ),
      TextFormField(
        keyboardType: TextInputType.phone,
        controller: _phoneNumController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
          hintText: 'Phone No.',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.phone, color: Colors.black),
        ),
        validator: (value) {
          bool numValid = RegExp(r"^[0-9]").hasMatch(value!);
          if (value.isEmpty) {
            return "Enter Phone No.";
          } else if (!numValid) {
            return "Enter Valid Phone No.";
          }
        },
      ),
      SizedBox(
        height: 20,
      ),
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
          hintText: 'E-Mail',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email, color: Colors.black),
        ),
        validator: (value) {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-z-A-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!);
          if (value.isEmpty) {
            return "Enter Email";
          } else if (!emailValid) {
            return "Enter Valid Email";
          }
        },
      ),
      SizedBox(
        height: 20,
      ),
      TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: _passwordController,
        obscureText: passToggle,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
          hintText: 'Password',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock, color: Colors.black),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Password";
          } else if (_passwordController.text.length < 8) {
            return "Password lenght should be more than 8 characters";
          }
          return null;
        },
      ),
      SizedBox(
        height: 20,
      ),
      TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: _confirmPwdController,
        obscureText: passToggle,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
          hintText: 'Confirm Password',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock, color: Colors.black),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Confirm Password";
          } else if (_confirmPwdController.text != _passwordController.text) {
            return "Password do not match";
          }
          return null;
        },
      ),
    ];
  }

  _buildButtons() {
    return [
      InkWell(
        onTap: () {
          if (_formfield.currentState!.validate()) {
            print('register success');
            _emailController.clear();
            _passwordController.clear();
          }
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFFDCD34),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Have an account already?",
            style: TextStyle(fontSize: 16),
          ),
          TextButton(
              onPressed: () {
                Get.toNamed(AppRoute.getSignIn());
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ))
        ],
      )
    ];
  }
}
