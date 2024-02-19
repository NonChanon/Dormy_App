import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key});

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
        itemCount: 10,
        itemBuilder: (context, index) {
          return NotificationItem();
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
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
