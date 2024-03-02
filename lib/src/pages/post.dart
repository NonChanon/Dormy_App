import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Post"),
          elevation: 2,
          shadowColor: Colors.black,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        body: SingleChildScrollView(
          child: buildPostContainer(),
        ));
  }

  Widget buildPostContainer() {
    return Container(
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
          buildReplyRow(),
          buildReplyRow(),
          buildReplyRow(),
          buildReplyRow(),
        ],
      ),
    );
  }

  Widget buildUserRow() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage('assets/image/profile_test.jpg'),
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
    final _commentController = TextEditingController();
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(Post());
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 0,
                  color: Color(0xFFE5E5E5),
                ),
                bottom: BorderSide(
                  width: 0,
                  color: Color(0xFFE5E5E5),
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _commentController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        hintText: 'Comment...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        prefixIcon: Icon(Icons.comment,
                            color: const Color.fromARGB(255, 124, 124, 124))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.send_rounded)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildReplyRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage('assets/image/profile_test.jpg'),
                    ),
                  ],
                ),
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  child: buildReplyDetails(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildReplyDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Chanon Kitbunnadaech",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          "Comment here",
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
