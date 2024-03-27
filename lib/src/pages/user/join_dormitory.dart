import 'dart:convert';

import 'package:dorm_app/utils/authController.dart';
import 'package:dorm_app/src/pages/home_page.dart';
import 'package:dorm_app/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class JoinDormitory extends StatefulWidget {
  const JoinDormitory({Key? key}) : super(key: key);

  @override
  State<JoinDormitory> createState() => _JoinDormitoryState();
}

class _JoinDormitoryState extends State<JoinDormitory> {

  final AuthController _authController = Get.put(AuthController());
  final _codeController = TextEditingController();

  void joinDormitory() async {
    final id = _authController.getIduser();
    final reqBody = {
      "idUser" : id,
      "codeRoom" : _codeController.text,
    };
    
    final response = await http.put(Uri.parse('http://10.98.0.51:8081/Api/User/UpdateIdRoom'),headers: {"Content-Type":"application/json"},body : jsonEncode(reqBody));
    final jsonRes = jsonDecode(response.body);

    if(response.statusCode >= 200 && response.statusCode < 300){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Join Room'),
            content: Text("Successful"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  
                  Get.offAll(HomePage());
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      await http.post(Uri.parse('http://10.98.0.51:8081/Api/Notify/CreateNotifyJoinDorm/$id'));
      
    }
    else
    {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Join Room Fail'),
            content: Text("Please try agin."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Dormy"),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: buildApartmentDetails(),
      ),
    );
  }

  Widget buildApartmentDetails() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Color(0xFFb7b7b7), blurRadius: 2.0, offset: Offset(0, 5)),
        ],
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding:
                      EdgeInsets.only(bottom: 15, top: 15, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  child: Text('Join Dormitory',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: buildInputForm("Enter the code", "Code"),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                joinDormitory();
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text('ENTER',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInputForm(String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller : _codeController,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          ),
        ),
      ],
    );
  }
}
