import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/announcement.dart';
import 'package:dorm_app/src/pages/admin/meter.dart';
import 'package:dorm_app/src/pages/report.dart';
import 'package:dorm_app/src/pages/admin/room_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final UserRole userRole = _authController.getCurrentUserRole();
    return Column(
      children: [
        Container(
          height: 320,
          child: PageView.builder(
            itemCount: 1,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
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
              _buildMenu(Icons.analytics, "Dashboard", RoomDetailPage()),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
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
                        'Happy Apartment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Room A101',
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
