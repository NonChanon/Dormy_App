import 'dart:convert';

import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyApartmentBody extends StatefulWidget {
  const MyApartmentBody({Key? key}) : super(key: key);

  @override
  State<MyApartmentBody> createState() => _MyApartmentBodyState();
}

class _MyApartmentBodyState extends State<MyApartmentBody> {

  final AuthController _authController = Get.put(AuthController());

  Future<PostData> fetchDormitoryDetails() async {
    final id = _authController.getIduser();
    final UserRole userRole = _authController.getCurrentUserRole();
    if(userRole == UserRole.admin)
    {
      String jsonString = '''
      {
        "dormitoryName": "AP HOUSE",
        "address": "ซอย เกกีงาม 1 ฉลองกรุง 1",
        "district": "ลาดกระบัง",
        "province": "กรุงเทพฯ",
        "postalCode": "10520",
        "phoneNumber": "0648791262",
        "email": "ap.house@gmail.com"
      }
      ''';

      Map<String, dynamic> jsonData = json.decode(jsonString); // แปลง JSON string เป็น Map
      PostData postData = PostData.fromJson(jsonData); // สร้างอ็อบเจกต์ PostData จาก Map
      return postData;
    }
    else
    {
      final response = await http.get(Uri.parse("http://10.98.0.51:8081/Api/Dormitory/GetDetailDormitory/$id"));
      if (response.statusCode == 200) {
        return PostData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load dormitory details');
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: FutureBuilder<PostData>(
          future: fetchDormitoryDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return buildApartmentDetails(snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget buildApartmentDetails(PostData postData) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle("Apartment Detail"),
          buildDetailRow(Icons.home, postData.dormitoryName, "Room " + _authController.getRoomName()),
          buildDetailRow(
              Icons.location_on, "Address", postData.address + ' ' + postData.district + ' ' + postData.province + ' ' + postData.postalCode),
          SizedBox(height: 15),
          buildSectionTitle("Contact"),
          buildDetailRow(Icons.phone, "Phone No.", postData.phoneNumber),
          buildDetailRow(Icons.email, "E-Mail", postData.email),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String title, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
      ),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(100),
            ),
            width: 50,
            height: 50,
            child: Icon(icon, size: 30),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class PostData {
  final String dormitoryName;
  final String address;
  final String district;
  final String province;
  final String postalCode;
  final String phoneNumber;
  final String email;

  PostData({
    required this.dormitoryName,
    required this.address,
    required this.district,
    required this.province,
    required this.postalCode,
    required this.phoneNumber,
    required this.email,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      dormitoryName: json['dormitoryName'] ?? '',
      address: json['address'] ?? '',
      district: json['district'] ?? '',
      province: json['province'] ?? '',
      postalCode: json['postalCode'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
    );
  }
}