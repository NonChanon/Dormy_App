import 'package:dorm_app/src/pages/new_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityBody extends StatefulWidget {
  const CommunityBody({Key? key}) : super(key: key);

  @override
  State<CommunityBody> createState() => _CommunityBodyState();
}

class _CommunityBodyState extends State<CommunityBody>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        Column(
          children: [
            buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildListView(),
                  Text("content2"),
                  Text("content3"),
                ],
              ),
            ),
          ],
        ),
        buildFloatingActionButton(),
      ],
    );
  }

  Widget buildTabBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(top: 5),
      color: Color(0xFFFDCD34),
      child: TabBar(
        unselectedLabelColor: Color(0xFF444444),
        labelColor: Colors.black,
        indicatorColor: Colors.black,
        controller: _tabController,
        tabs: [
          Tab(text: 'Public', icon: Icon(Icons.public)),
          Tab(text: 'My Apartment', icon: Icon(Icons.apartment)),
          Tab(text: 'Announcement', icon: Icon(Icons.newspaper)),
        ],
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return buildPostContainer();
      },
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

  Widget buildFloatingActionButton() {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: FloatingActionButton(
        backgroundColor: Color(0xFFFDCD34),
        onPressed: () {
          Get.to(NewPostPage());
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
    );
  }
}
