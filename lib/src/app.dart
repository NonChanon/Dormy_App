import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/admin/build_dormitory.dart';
import 'package:dorm_app/src/pages/home_page.dart';
import 'package:dorm_app/src/pages/user/join_dormitory.dart';
import 'package:dorm_app/src/pages/sign_in.dart';
import 'package:dorm_app/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DormyApp extends StatelessWidget {
  const DormyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(AuthController());

    return GetMaterialApp(
      title: "DormyApp",
      getPages: AppRoute.routes,
      initialRoute:
          AppRoute.getSignIn(), // เริ่ม initial route ด้วยหน้า Sign In
      // ตรวจสอบการเปลี่ยนแปลงในค่า isLoggedIn และนำทางไปยังหน้าที่เหมาะสม
      home: Obx(() {
        final UserRole userRole = _authController.getCurrentUserRole();
        final bool isLoggedIn = _authController.isLoggedIn.value;
        final bool haveDormitory = _authController
            .checkIfUserHaveDormitory(); // ตรวจสอบว่ามีหอพักหรือไม่

        if (isLoggedIn) {
          // ถ้าเข้าสู่ระบบแล้ว
          if (haveDormitory) {
            // ถ้ามีหอพัก
            switch (userRole) {
              case UserRole.admin:
                // ถ้าเป็น admin ให้ไปที่หน้า home page
                return HomePage();
              case UserRole.user:
                // ถ้าเป็น user ให้ไปที่หน้า home page
                return HomePage();
            }
          } else {
            // ถ้าไม่มีหอพัก
            switch (userRole) {
              case UserRole.admin:
                // ถ้าเป็น admin ให้ไปที่หน้า buildDorm
                return BuildDormitory();
              case UserRole.user:
                // ถ้าเป็น user ให้ไปที่หน้า joinDormitory
                return JoinDormitory();
            }
          }
        } else {
          // ถ้ายังไม่เข้าสู่ระบบ ให้ไปที่หน้า Sign In
          return SignIn();
        }
      }),
    );
  }
}
