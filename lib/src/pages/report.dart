import 'package:dorm_app/src/pages/new_report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReportAppBar(),
      body: ReportList(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }
}

Widget buildBody() {
  return Stack(
    children: [
      Column(
        children: [ReportList()],
      ),
      buildFloatingActionButton(),
    ],
  );
}

class ReportAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text("Report History"),
      elevation: 5,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
    );
  }
}

class ReportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ReportItem();
        },
      ),
    );
  }
}

class ReportItem extends StatelessWidget {
  @override
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
                Text("Your Report",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("has been received."),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "12 hours ago",
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

Widget buildFloatingActionButton() {
  return Positioned(
    bottom: 20.0,
    right: 20.0,
    child: FloatingActionButton(
      backgroundColor: Color(0xFFFDCD34),
      onPressed: () {
        Get.to(NewReportPage());
      },
      child: Icon(Icons.add),
      shape: CircleBorder(),
    ),
  );
}
