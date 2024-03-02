import 'package:dorm_app/src/pages/admin/build_building.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildDormitory extends StatefulWidget {
  const BuildDormitory({Key? key}) : super(key: key);

  @override
  State<BuildDormitory> createState() => _BuildDormitoryState();
}

class _BuildDormitoryState extends State<BuildDormitory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Dormy"),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: buildApartmentDetails(),
      ),
    );
  }

  Widget buildApartmentDetails() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Color(0xFFb7b7b7), blurRadius: 2.0, offset: Offset(0, 5)),
        ],
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding:
                      EdgeInsets.only(bottom: 15, top: 15, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  child: Text('Create Dormitory',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    buildInputForm("Dormitory's name", "Name"),
                    SizedBox(
                      height: 10,
                    ),
                    buildInputForm("Address", "Address"),
                    SizedBox(
                      height: 10,
                    ),
                    buildInputForm("Telephone Number", "Tel."),
                    SizedBox(
                      height: 10,
                    ),
                    buildInputForm("E-Mail", "E-Mail"),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(BuildBuilding());
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text('NEXT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInputForm(String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(
          height: 5,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          ),
        ),
      ],
    );
  }
}
