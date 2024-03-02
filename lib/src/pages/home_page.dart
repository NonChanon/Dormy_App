import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/user/Invoice.dart';
import 'package:dorm_app/src/pages/community.dart';
import 'package:dorm_app/src/pages/home.dart';
import 'package:dorm_app/src/pages/admin/management.dart';
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
  final AuthController _authController = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Widget> userPages = [
    Home(),
    Community(),
    Invoice(),
    MyApartment(),
  ];

  final List<IconData> userItems = [
    Icons.home,
    Icons.people,
    Icons.receipt,
    Icons.apartment,
  ];

  final List<String> userName = [
    'Home',
    'Community',
    'Invoice',
    'My Apartment'
  ];

  final List<Widget> adminPages = [
    Home(),
    Community(),
    Management(),
    MyApartment(),
  ];

  final List<IconData> adminItems = [
    Icons.home,
    Icons.people,
    Icons.settings,
    Icons.apartment,
  ];

  final List<String> adminName = [
    'Home',
    'Community',
    'Management',
    'My Apartment'
  ];
  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleLogOut() {
    Get.offAllNamed('/sign_in');
  }

  @override
  Widget build(BuildContext context) {
    UserRole userRole = _authController.getCurrentUserRole();
    List<Widget> pages = [];
    switch (userRole) {
      case UserRole.admin:
        pages = adminPages;
        break;
      case UserRole.user:
        pages = userPages;
        break;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      body: pages[_selectedIndex],
      endDrawer: buildDrawer(), // ใช้ endDrawer แทน drawer
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar() {
    UserRole userRole = _authController.getCurrentUserRole();
    List<String> titleName = [];
    switch (userRole) {
      case UserRole.admin:
        titleName = adminName;
        break;
      case UserRole.user:
        titleName = userName;
        break;
    }
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(titleName[_selectedIndex]),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.notifications,
            size: 26,
            color: Colors.black,
          ),
          onPressed: () {
            Get.to(NotificationPage());
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.menu,
            size: 26,
            color: Colors.black,
          ),
          onPressed: () {
            _scaffoldKey.currentState
                ?.openEndDrawer(); // เปลี่ยนเป็น openEndDrawer
          },
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFFDCD34),
            ),
            accountName: Text(
              "Chanon Kitbunnadaech",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            accountEmail: Text(
              "chn@gmail.com",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/image/profile_picture.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Edit Profile',
                style: TextStyle(fontWeight: FontWeight.w500)),
            onTap: () {
              // Do something when Edit Profile is tapped
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title:
                Text('Logout', style: TextStyle(fontWeight: FontWeight.w500)),
            onTap: () {
              _authController.isLoggedIn.value = false;
              _handleLogOut();
              print(_authController.isLoggedIn.value);
              // Do something when Logout is tapped
            },
          ),
        ],
      ),
    );
  }

  CurvedNavigationBar buildBottomNavigationBar() {
    UserRole userRole = _authController.getCurrentUserRole();
    List<IconData> items = [];
    switch (userRole) {
      case UserRole.admin:
        items = adminItems;
        break;
      case UserRole.user:
        items = userItems;
        break;
    }
    return CurvedNavigationBar(
        onTap: onTapNav,
        index: _selectedIndex,
        color: Colors.black,
        backgroundColor: Colors.transparent,
        items: items
            .map((icon) => Icon(icon, size: 26, color: Colors.white))
            .toList());
  }
}
