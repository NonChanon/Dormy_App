import 'dart:convert';

import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final AuthController _authController = Get.put(AuthController());
final _notify = <NotifyData>[];

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  @override
  void initState() {
    super.initState();
    fetchGetNotify();
  }

  fetchGetNotify() async {
    final idUser = _authController.getIduser();
    var response = await http.get(Uri.parse("http://10.98.0.51:8081/Api/Notify/GetNotify/$idUser"));
    if (response.statusCode == 200) {
      _notify.clear();
      List<NotifyData> notify = [];
      var jsonResponse = jsonDecode(response.body);
      for (var data in jsonResponse) {
        notify.add(NotifyData.fromJson(data));
      }
      setState(() {_notify.addAll(notify);});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationAppBar(),
      body: NotificationList(),
    );
  }
}

class NotificationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text("Notification"),
      elevation: 5,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
    );
  }
}

class NotificationList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _notify.length,
        itemBuilder: (context, index) {
          return NotificationItem(index : index);
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
    final int index;
    const NotificationItem({Key? key,required this.index});
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 80,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0xFFb7b7b7), blurRadius: 2.0, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.newspaper, size: 34),
              ],
            ),
            width: 80,
            height: 80,
            color: Colors.amber,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_notify[this.index].title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(_notify[this.index].details,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Add overflow handling
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      getTimeDifference(_notify[index].timeStamp),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

String getTimeDifference(String timeStamp) {
  DateTime now = DateTime.now();
  DateTime postTime = DateTime.parse(timeStamp);

  Duration difference = now.difference(postTime);

  if (difference.inDays > 365) {
    int years = (difference.inDays / 365).floor();
    return '$years years ago';
  } else if (difference.inDays > 30) {
    int months = (difference.inDays / 30).floor();
    return '$months months ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} days ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'just now';
  }
}

class NotifyData {
  final String idNotify;
  final String idUser;
  final String category;
  final String title;
  final String details;
  final bool status;
  final String timeStamp;

  NotifyData({
    required this.idNotify,
    required this.idUser,
    required this.category,
    required this.title,
    required this.details,
    required this.status,
    required this.timeStamp,
  });

  factory NotifyData.fromJson(Map<String, dynamic> json) {
    return NotifyData(
      idNotify: json['idNotify'] ?? '',
      idUser: json['idUser'] ?? '',
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      details: json['details'] ?? '',
      status: json['status'] ?? false,
      timeStamp: json['timesTamp'] ?? '',
    );
  }
}