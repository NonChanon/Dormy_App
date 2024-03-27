import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


enum UserRole {
  admin,
  user,
}

class AuthController extends GetxController {
  
  var isLoggedIn = false.obs;
  var haveDorm = false.obs;
  var currentUserRole = UserRole.user.obs;
  var url = Uint8List;
  late SharedPreferences prefs;

  AuthController() {
    initSharedPref(); // เรียกใช้ initSharedPref() ที่นี่
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    
  }

  
  
  Future<bool> checkIfUserHaveDormitory() async {
    try {
      final JwtDecoderToken = JwtDecoder.decode(prefs.getString("token").toString());
      final id = JwtDecoderToken["userID"];
      final response = await http.get(Uri.parse("http://10.98.0.51:8081/Api/User/checkDorm/$id"));
      print("statusCode : " + response.statusCode.toString() + " Id : " + id);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonRes = jsonDecode(response.body);
        print("check room " + jsonRes.toString());
        return jsonRes;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }


  bool login() {
    if (prefs.getString("token")!.isNotEmpty) {
      return true;
    }
    else{
      return false;
    }
  }

  String getRoomName() {
    return prefs.getString("roomName").toString();
  }

  void setRoomName(String roomName) {
    prefs.setString("roomName",roomName);
  }

  String getEmail() {
    return prefs.getString("email").toString();
  }

  void serEmail(String email) {
    prefs.setString("email",email);
  }

  String getIdRoom() {
    return prefs.getString("idRoom").toString();
  }

  void setIdRoom(String idRoom) {
    prefs.setString("idRoom",idRoom);
  }

  String getIduser() {
    final JwtDecoderToken = JwtDecoder.decode(prefs.getString("token").toString());
    return JwtDecoderToken["userID"];
  }

  String getFullName() {
    final JwtDecoderToken = JwtDecoder.decode(prefs.getString("token").toString());
    return JwtDecoderToken["firstname"] + " " + JwtDecoderToken["lastname"];
  }

  UserRole getCurrentUserRole() {
    final JwtDecoderToken = JwtDecoder.decode(prefs.getString("token").toString());
    if (JwtDecoderToken["role"] == "owner")
      return UserRole.admin;
    else
      return UserRole.user;

  }
}
