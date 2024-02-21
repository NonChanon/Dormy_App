import 'package:flutter/material.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnnouncementAppBar(),
      body: buildListView(),
    );
  }
}

class AnnouncementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text("Announcement"),
      elevation: 5,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
    );
  }
}

Widget buildListView() {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return buildPostContainer();
      },
    ),
  );
}

Widget buildPostContainer() {
  return Container(
    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0xFFb7b7b7),
          blurRadius: 2.0,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      children: [
        buildUserRow(),
        buildPostDetailRow(),
        buildPostImage(),
        buildCommentRow(),
      ],
    ),
  );
}

Widget buildUserRow() {
  return Container(
    child: Row(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/image/roomTest.jpg'),
              ),
            ],
          ),
          width: 80,
          height: 80,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 20),
            child: buildUserDetails(),
          ),
        )
      ],
    ),
  );
}

Widget buildUserDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Chanon Kitbunnadaech",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.more_horiz)
        ],
      ),
      Text(
        "12 hours ago",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget buildPostDetailRow() {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: Row(
      children: [Text("Test post detail")],
    ),
  );
}

Widget buildPostImage() {
  return Container(
    height: 380,
    child: Image(
      image: AssetImage('assets/image/roomTest.jpg'),
      fit: BoxFit.cover,
    ),
  );
}

Widget buildCommentRow() {
  return Container(
    margin: EdgeInsets.only(right: 20, bottom: 10, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Text("2 comments")],
    ),
  );
}
