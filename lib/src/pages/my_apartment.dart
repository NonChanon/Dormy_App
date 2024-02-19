import 'package:dorm_app/src/component/my_apartment_body.dart';
import 'package:flutter/material.dart';

class MyApartment extends StatelessWidget {
  const MyApartment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyApartmentBody(),
    );
  }
}
