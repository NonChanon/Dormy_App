import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/admin/build_dormitory.dart';
import 'package:dorm_app/src/pages/home_page.dart';
import 'package:dorm_app/src/pages/user/join_dormitory.dart';
import 'package:dorm_app/src/pages/sign_in.dart';
import 'package:dorm_app/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DormyApp extends StatelessWidget {
  const DormyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(AuthController());

    return GetMaterialApp(
      getPages: AppRoute.routes,
      title: "DormyApp",
      home: SignIn(), // เริ่มต้นที่หน้า SignIn
    );

    // return GetMaterialApp(
    //   title: "DormyApp",
    //   getPages: AppRoute.routes,
    //   initialRoute: AppRoute.getSignIn(),
    //   home: FutureBuilder<bool>(
    //     future: _authController.checkIfUserHaveDormitory(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Scaffold(
    //           body: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         );
    //       } else {
    //         if (snapshot.hasError) {
    //           return Scaffold(
    //             body: Center(
    //               child: Text('Error: ${snapshot.error}'),
    //             ),
    //           );
    //         } else {
    //           final UserRole userRole = _authController.getCurrentUserRole();
    //           final bool isLoggedIn = _authController.login();
    //           final bool haveDormitory = snapshot.data!;

    //           if (isLoggedIn) {
    //             if (haveDormitory) {
    //               switch (userRole) {
    //                 case UserRole.admin:
    //                   return HomePage();
    //                 case UserRole.user:
    //                   return HomePage();
    //               }
    //             } else {
    //               switch (userRole) {
    //                 case UserRole.admin:
    //                   return BuildDormitory();
    //                 case UserRole.user:
    //                   return JoinDormitory();
    //               }
    //             }
    //           } else {
    //             return SignIn();
    //           }
    //         }
    //       }
    //     },
    //   ),
    // );
  }
}
