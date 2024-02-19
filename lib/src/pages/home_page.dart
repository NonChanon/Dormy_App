import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dorm_app/src/pages/Invoice.dart';
import 'package:dorm_app/src/pages/community.dart';
import 'package:dorm_app/src/pages/home.dart';
import 'package:dorm_app/src/pages/my_apartment.dart';
import 'package:dorm_app/src/pages/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> pages = [
    Home(),
    Community(),
    Invoice(),
    MyApartment(),
  ];

  final List<IconData> items = [
    Icons.home,
    Icons.people,
    Icons.receipt,
    Icons.apartment,
  ];

  final List<String> titleName = [
    'Home',
    'Community',
    'Invoice',
    'My Apartment'
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: pages[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(titleName[_selectedIndex]),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Get.to(NotificationPage());
          },
          child: Icon(
            Icons.notifications,
            size: 26,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 5),
        IconButton(
          icon: const Icon(
            Icons.menu,
            size: 26,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black,
    );
  }

  CurvedNavigationBar buildBottomNavigationBar() {
    return CurvedNavigationBar(
      onTap: onTapNav,
      index: _selectedIndex,
      color: Colors.black,
      backgroundColor: Colors.transparent,
      items: items
          .map((icon) => Icon(icon, size: 26, color: Colors.white))
          .toList(),
    );
  }
}
