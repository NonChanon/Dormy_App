import 'dart:convert';
import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/announcement.dart';
import 'package:dorm_app/src/pages/admin/meter.dart';
import 'package:dorm_app/src/pages/dashboard.dart';
import 'package:dorm_app/src/pages/report.dart';
import 'package:dorm_app/src/pages/admin/room_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key});
  

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final AuthController _authController = Get.put(AuthController());

  Future<PostData> fetchPostData() async {
    final id = _authController.getIduser();
    final UserRole userRole = _authController.getCurrentUserRole();
    print("ID : " + id);
    if(userRole == UserRole.admin)
    {
      String jsonString = '{"dormitoryName": "AP HOUSE", "idRoom": "", "roomName": 0}';
      Map<String, dynamic> jsonMap = json.decode(jsonString); // แปลง JSON string เป็น Map
      PostData postData = PostData.fromJson(jsonMap); // สร้างอ็อบเจกต์ PostData จาก Map
      return postData;
      
    }
    else
    {
      final response = await http.get(Uri.parse("http://10.98.0.51:8081/Api/Dormitory/GetNameDormitory/$id"));
      if (response.statusCode == 200) {
        // ถ้าสำเร็จ ส่งค่ากลับในรูปแบบของ PostData
        return PostData.fromJson(json.decode(response.body));
      } else {
        // ถ้าเกิดข้อผิดพลาด ส่งค่าเป็น null
        throw Exception('Failed to load post data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserRole userRole = _authController.getCurrentUserRole();
    return Column(
      children: [
        Container(
          height: 320,
          child: FutureBuilder<Widget>(
            future: _buildPageItem(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return snapshot.data ?? SizedBox(); // ในกรณีที่ไม่มีข้อมูลให้ใช้ SizedBox() แทน
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Text(
                "Future",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildMenu(Icons.newspaper, "Announce", AnnouncementPage()),
              SizedBox(
                width: 20,
              ),
              _buildMenu(Icons.announcement, "Report", ReportPage()),
              SizedBox(
                width: 20,
              ),
              if (userRole == UserRole.admin) // ถ้า userRole เป็น 'admin'
                _buildMenu(Icons.electric_meter, "Meter", Meter()),
              if (userRole == UserRole.admin) // ถ้า userRole เป็น 'admin'
                SizedBox(width: 20), // ใส่ SizedBox ใน if condition
              _buildMenu(Icons.analytics, "Dashboard", Dashboard()),
            ],
          ),
        )
      ],
    );
  }

  Future<Widget> _buildPageItem() async {
    final postData = await fetchPostData();
    _authController.setRoomName(postData.roomName.toString());
    _authController.setIdRoom(postData.idRoom);
    return Stack(
      children: [
        Container(
          height: 270,
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/image/roomTest.jpg"),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            margin: EdgeInsets.only(left: 40, right: 40, bottom: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xFFFDCD34),
            ),
            alignment: Alignment.center,
            child: Container(
              height: 320,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 26),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        postData.dormitoryName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Room " + postData.roomName.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenu(IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => page));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFDCD34),
            ),
            child: Icon(icon, size: 35),
          ),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
class PostData {
  final String dormitoryName;
  final String idRoom;
  final int roomName;

  PostData({
    required this.dormitoryName,
    required this.idRoom,
    required this.roomName,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      dormitoryName: json['dormitoryName'] ?? '',
      idRoom: json['idRoom'] ?? '',
      roomName: json['roomName'] ?? 0,
    );
  }
}