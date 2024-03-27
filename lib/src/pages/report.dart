import 'dart:convert';

import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/user/new_report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class ReportPage extends StatelessWidget {

  const ReportPage({Key? key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReportAppBar(),
      body: ReportList(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildFloatingActionButton() {
  return Positioned(
    bottom: 20.0,
    right: 20.0,
    child: FloatingActionButton(
      backgroundColor: Color(0xFFFDCD34),
      onPressed: () {
        Get.to(NewReportPage());
      },
      child: Icon(Icons.add),
      shape: CircleBorder(),
    ),
  );
}
}

class ReportAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text("Report History"),
      elevation: 5,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
    );
  }
}

class ReportList extends StatelessWidget {

  final AuthController _authController = Get.put(AuthController());
  final reportData = <ReortData>[].obs;

  Future<void> fetchReportData() async {
    final idRoom = _authController.getIdRoom();
    var response = await http.get(Uri.parse("http://10.98.0.51:8081/Api/Problem/GetProblemAllByIdRoom/$idRoom"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (var data in jsonResponse) {
        reportData.add(ReortData.fromJson(data));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchReportData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // แสดง Loading Indicator หรืออะไรก็ตามตามที่ต้องการ
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // กรณีเกิด Error ในการโหลดข้อมูล
          return Text('Error: ${snapshot.error}');
        } else {
          // แสดงรายการ ReportItem ตามข้อมูลที่โหลดเสร็จสมบูรณ์
          return Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ListView.builder(
              itemCount: reportData.length,
              itemBuilder: (context, index) {
                return ReportItem(reportData[index]);
              },
            ),
          );
        }
      },
    );
  }

  Widget ReportItem (ReortData data) {
    return Container(
      width: double.maxFinite,
      height: 80,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0xFFb7b7b7), blurRadius: 2.0, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.newspaper, size: 34),
              ],
            ),
            width: 80,
            height: 80,
            color: Colors.amber,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.category,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(data.details),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      getTimeDifference(data.timestamp),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

String getTimeDifference(DateTime timeStamp) {
  DateTime now = DateTime.now();
  DateTime postTime = timeStamp;

  Duration difference = now.difference(postTime);

  if (difference.inDays > 365) {
    int years = (difference.inDays / 365).floor();
    return '$years years ago';
  } else if (difference.inDays > 30) {
    int months = (difference.inDays / 30).floor();
    return '$months months ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} days ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'just now';
  }
}

class ReortData {
  final String idProblem;
  final String idRoom;
  final String idUser;
  final String category;
  final String title;
  final String details;
  final DateTime timestamp;

  ReortData({
    required this.idProblem,
    required this.idRoom,
    required this.idUser,
    required this.category,
    required this.title,
    required this.details,
    required this.timestamp,
  });

  factory ReortData.fromJson(Map<String, dynamic> json) {
    return ReortData(
      idProblem: json['idProblem'] ?? '',
      idRoom: json['idRoom'] ?? '',
      idUser: json['idUser'] ?? '',
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      details: json['details'] ?? '',
      timestamp: DateTime.parse(json['timesTamp']),
    );
  }
}