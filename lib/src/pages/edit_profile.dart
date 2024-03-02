import 'dart:io';

import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _imageFile; // รูปภาพที่ถูกเลือก
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Edit Profile"),
        elevation: 2,
        shadowColor: Colors.black,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 135,
              height: 135,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFDCD34).withOpacity(0.6),
              ),
              child: Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      AssetImage('assets/image/profile_test.jpg'), // รูปโปรไฟล์
                ),
              ),
            ),
            // SizedBox(height: 40),
            // GestureDetector(
            //   onTap: _chooseImage,
            //   child: CircleAvatar(
            //     radius: 70,
            //     backgroundImage: AssetImage('assets/image/profile_test.jpg'),
            //     // backgroundImage: _imageFile != null
            //     //     ? FileImage(_imageFile!)
            //     //     : AssetImage('assets/default_profile_image.jpg'),
            //   ),
            // ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Edit Photo',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 216, 166, 2)),
                )),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
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
                    controller: _surnameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
                      hintText: 'Lastname',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                    ),
                    validator: (value) {
                      bool lastnameValid =
                          RegExp(r"^[a-zA-Z]").hasMatch(value!);
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
                    controller: _phoneController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
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
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
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
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFFDCD34),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _chooseImage() {
    // TODO: เพิ่มโค้ดสำหรับการเลือกรูปภาพ
  }

  void _saveProfile() {
    // TODO: เพิ่มโค้ดสำหรับการบันทึกข้อมูลโปรไฟล์
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
