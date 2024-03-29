import 'package:dorm_app/src/pages/admin/build_room_detail.dart';
import 'package:dorm_app/src/pages/announcement.dart';
import 'package:dorm_app/src/pages/user/new_report.dart';
import 'package:dorm_app/src/pages/report.dart';
import 'package:dorm_app/src/pages/admin/room_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Management extends StatefulWidget {
  const Management({Key? key});

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  TextEditingController _searchController = TextEditingController();

  Color _getStatusColor(String label) {
    switch (label) {
      case 'Available':
        return Colors.green;
      case 'Rented':
        return Colors.red;
      case 'Unpaid':
        return Colors.amber;
      case 'Paid':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  String _getStatusText(String label) {
    switch (label) {
      case 'Available':
        return 'Available';
      case 'Rented':
        return 'Rented';
      case 'Unpaid':
        return 'Unpaid';
      case 'Paid':
        return 'Paid';
      default:
        return '';
    }
  }

  IconData _getStatusIcon(String label) {
    switch (label) {
      case 'Unpaid':
        return Icons.pending_actions;
      case 'Paid':
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 245,
            child: PageView.builder(
              itemCount: 1,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
            ),
            padding: EdgeInsets.only(bottom: 20),
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _filterMenu("Available"),
                SizedBox(width: 10),
                _filterMenu("Rented"),
                SizedBox(width: 10),
                _filterMenu("Unpaid"),
                SizedBox(width: 10),
                _filterMenu("Paid"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  "Room",
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
          _buildMenu(),
        ],
      )),
    );
  }

  Widget _buildPageItem(int index) {

    return Stack(
      children: [
        Container(
          height: 200,
          color: Colors.black,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
              onTap: () {
                _showAlertDialog(context);
              },
              child: Container(
                height: 60,
                margin: EdgeInsets.only(left: 40, right: 40, top: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFDCD34),
                ),
                alignment: Alignment.center,
                child: Container(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(width: 1, color: Colors.black)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.apartment, size: 26),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'AP HOUSE',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Text(
                          'Building A',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: InkWell(
        //     onTap: () {
        //       _showAlertDialog(context);
        //     },
        //     child: Container(
        //       height: 40,
        //       width: 120,
        //       margin: EdgeInsets.only(left: 40, right: 40, top: 10),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(5),
        //         color: Color(0xFFFDCD34),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           // Icon(Icons.location_on_outlined, size: 26),
        //           Text(
        //             '1st Floor',
        //             style: TextStyle(
        //               fontSize: 16,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 25,
          left: 40,
          right: 40,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search room number...",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {},
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

  Widget _filterMenu(String label) {
    return Container(
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: Text(label),
        ),
      ]),
    );
  }

  Widget _buildMenu() {
    final data = [
      {"roomName": "101", "statusText": "Paid", "isStay": true},
      {"roomName": "102", "statusText": "Unpaid", "isStay": false},
      {"roomName": "103", "statusText": "Unpaid", "isStay": false},
      {"roomName": "104", "statusText": "Unpaid", "isStay": false},
      {"roomName": "201", "statusText": "Unpaid", "isStay": false},
      {"roomName": "202", "statusText": "Unpaid", "isStay": false},
      {"roomName": "203", "statusText": "Unpaid", "isStay": false},
      {"roomName": "204", "statusText": "Unpaid", "isStay": false},
    ];
    return SingleChildScrollView(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: List.generate(
          8,
          (index) => SizedBox(
            width: 110,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RoomDetailPage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: data[index]['isStay'].toString() == "false" ? Colors.grey : Color(0xFFFDCD34),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data[index]['roomName'].toString(),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 35,
                            color: Color(0xFFF5F5F5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(
                                //   Icons.check_circle_outline,
                                //   size: 24,
                                //   color: Colors.green,
                                // ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                // Text(
                                //   'Paid',
                                //   style: TextStyle(
                                //       color: Colors.green,
                                //       fontWeight: FontWeight.bold,
                                //       fontSize: 16),
                                // )
                                Icon(
                                  _getStatusIcon(data[index]['statusText'].toString()),
                                  size: 24,
                                  color: _getStatusColor(data[index]['statusText'].toString()),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _getStatusText(data[index]['statusText'].toString()),
                                  style: TextStyle(
                                      color: _getStatusColor(data[index]['statusText'].toString()),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                                // Text(
                                //   'Available',
                                //   style: TextStyle(
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.w500,
                                //       fontSize: 16),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                width: 110,
                height: 110,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // ปรับความโค้งของขอบตามต้องการ
          ),
          backgroundColor: Colors.white,
          title: Container(
            child: Text('Select Details',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          content: buildApartmentDetails(),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

Widget buildApartmentDetails() {
  return Container(
    width: 300,
    height: 260,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Column(
            children: [
              buildInputForm("Dormitory's name", "Name", ['AP HOUSE']),
              SizedBox(
                height: 10,
              ),
              buildInputForm("Building's name", "Name", ['A']),
              // SizedBox(
              //   height: 10,
              // ),
              // buildInputForm("Floor", "Number", ['1', '2', '3']),
            ],
          )),
        ],
      ),
    ),
  );
}

Widget buildInputForm(String label, String placeholder, List<String> options) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      SizedBox(
        height: 5,
      ),
      DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: placeholder,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        ),
        items: options.map((String option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (String? value) {
          // เพิ่มโค้ดที่คุณต้องการให้ทำงานเมื่อมีการเลือกตัวเลือกใน Dropdown ที่นี่
        },
      ),
    ],
  );
}
