import 'package:dorm_app/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DormyApp extends StatelessWidget {
  const DormyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "DormyApp",
      getPages: AppRoute.routes,
      initialRoute: AppRoute.initial,
    );
  }
}
