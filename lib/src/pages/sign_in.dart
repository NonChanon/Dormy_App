import 'dart:convert';
import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/admin/build_dormitory.dart';
import 'package:dorm_app/src/pages/home_page.dart';
import 'package:dorm_app/src/pages/user/join_dormitory.dart';
import 'package:dorm_app/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthController _authController = Get.find();
  final _formfield = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passToggle = true;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void login() async {
    final reqBody = {
      "email" : _emailController.text,
      "password" : _passwordController.text,
    };

    final response = await http.post(Uri.parse('http://10.98.0.51:8081/Api/User/Login'),headers: {"Content-Type":"application/json"},body : jsonEncode(reqBody));
    final jsonRes = jsonDecode(response.body);
    if(response.statusCode >= 200 && response.statusCode < 300){
      final token = jsonRes["token"];
      prefs.setString("token", token);
      _authController.serEmail(_emailController.text);
      _authController.login();
      bool hasDormitory = await _authController.checkIfUserHaveDormitory();
      switch (_authController.getCurrentUserRole()) {
        case UserRole.admin:
          if (await _authController.checkIfUserHaveDormitory()) {
            Get.offAll(
                HomePage()); // นำทางไปยังหน้า HomePage สำหรับ admin ที่มีหอพัก
          } else {
            Get.offAll(
                BuildDormitory()); // นำทางไปยังหน้าสร้าง Dormitory สำหรับ admin ที่ยังไม่มีหอพัก
          }
        case UserRole.user:
          if (await _authController.checkIfUserHaveDormitory()) {
            Get.offAll(
                HomePage()); // นำทางไปยังหน้า HomePage สำหรับ user ที่มีหอพัก
          } else {
            Get.offAll(
                JoinDormitory()); // นำทางไปยังหน้า JoinDormitory สำหรับ user ที่ยังไม่มีหอพัก
          }
          break;
      } // เมื่อลงชื่อเข้าใช้สำเร็จให้นำทางไปยังหน้าหลัก
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Register Failed'),
            content: Text(jsonRes['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _handleLogin() {
    if (_formfield.currentState!.validate()) {
      login();
      // print('success');
      // _authController.login(); // เรียกใช้เมธอด login จาก Controller เมื่อลงชื่อเข้าใช้สำเร็จ
      // print(_authController.isLoggedIn.value);
      // switch (_authController.getCurrentUserRole()) {
      //   case UserRole.admin:
      //     if (_authController.checkIfUserHaveDormitory()) {
      //       Get.offAll(
      //           HomePage()); // นำทางไปยังหน้า HomePage สำหรับ admin ที่มีหอพัก
      //     } else {
      //       Get.offAll(
      //           BuildDormitory()); // นำทางไปยังหน้าสร้าง Dormitory สำหรับ admin ที่ยังไม่มีหอพัก
      //     }
      //   case UserRole.user:
      //     if (_authController.checkIfUserHaveDormitory()) {
      //       Get.offAll(
      //           HomePage()); // นำทางไปยังหน้า HomePage สำหรับ user ที่มีหอพัก
      //     } else {
      //       Get.offAll(
      //           JoinDormitory()); // นำทางไปยังหน้า JoinDormitory สำหรับ user ที่ยังไม่มีหอพัก
      //     }
      //     break;
      // } // เมื่อลงชื่อเข้าใช้สำเร็จให้นำทางไปยังหน้าหลัก
    }
  }

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
                SizedBox(height: 100),
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

  _buildTextFields() {
    return [
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
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
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
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
    ];
  }

  _buildButtons() {
    return [
      InkWell(
        onTap: () {
          _handleLogin();
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFFDCD34),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(fontSize: 16),
          ),
          TextButton(
              onPressed: () {
                Get.toNamed(AppRoute.getSignUp());
              },
              child: Text(
                'Sign up',
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
