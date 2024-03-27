import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dorm_app/src/pages/new_post.dart';
import 'package:dorm_app/src/pages/post.dart';
import 'package:flutter/services.dart';

class PostId {
  final String id;
  PostId(this.id);
}

class CommunityBody extends StatefulWidget {
  const CommunityBody({Key? key}) : super(key: key);

  @override
  State<CommunityBody> createState() => _CommunityBodyState();
}

class _CommunityBodyState extends State<CommunityBody> with TickerProviderStateMixin {
  final AuthController _authController = Get.put(AuthController());
  late TabController _tabController;
  final postPublic = <PostId>[].obs;
  final postApartment = <PostId>[].obs;
  final postAnnouncement = <PostId>[].obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchPosts();
    fetchPostApartment();
    fetchPostAnnouncement();
  }

  fetchPosts() async {
    var response =
        await http.get(Uri.parse("http://10.98.0.51:8081/Api/Community/GetPostPublic"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (var id in jsonResponse) {
        postPublic.add(PostId(id));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  fetchPostApartment() async {
    final idUser = _authController.getIduser();
    var response =
        await http.get(Uri.parse("http://10.98.0.51:8081/Api/Community/GetPostApartment/$idUser"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (var id in jsonResponse) {
        postApartment.add(PostId(id));
      }
    }
  }

  fetchPostAnnouncement() async {
    final idUser = _authController.getIduser();
    var response =
        await http.get(Uri.parse("http://10.98.0.51:8081/Api/Community/GetPostAnnouncement/$idUser"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (var id in jsonResponse) {
        postAnnouncement.add(PostId(id));
      }
    }
  }

  Future<PostData> fetchPostData(String id) async {
    final response = await http.get(Uri.parse("http://10.98.0.51:8081/Api/Community/GetPost/$id"));
    if (response.statusCode == 200) {
      // ถ้าสำเร็จ ส่งค่ากลับในรูปแบบของ PostData
      return PostData.fromJson(json.decode(response.body));
    } else {
      // ถ้าเกิดข้อผิดพลาด ส่งค่าเป็น null
      throw Exception('Failed to load post data');
    }
  }
  
  Future<Uint8List> fetchImageBytes(String idUser) async {
    final response = await http.get(Uri.parse('http://10.98.0.51:8081/Api/User/getProFile/$idUser'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      
      final defaultImage = await rootBundle.load('assets/image/profile_test.jpg');
      return defaultImage.buffer.asUint8List();
    }
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
                  buildListView(postPublic),
                  buildListView(postApartment),
                  buildListView(postAnnouncement),
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

  Widget buildListView(List<PostId> posts) {
    
    return Obx(() => ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return buildPostContainer(posts[index].id);
      },
    ));
  }

  Widget buildPostContainer(String id) {
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
      child: FutureBuilder<List<Widget>>(
        future: Future.wait([
          buildPostUserAndDetailAPI(id),
          buildPostImageAPI(id),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // หรือ Widget ใดๆ ที่ต้องการแสดงขณะรอ
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Widget> widgets = snapshot.data ?? [];
            return Column(
              children: [
                if (widgets.isNotEmpty) ...widgets,
                buildCommentRow(id),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Widget> buildPostUserAndDetailAPI(String id) async {
    
      final postData = await fetchPostData(id); // เรียกใช้ fetchPostData เพื่อดึงข้อมูลโพสต์
      final img = await fetchImageBytes(postData.idUser);

      return Column(
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
                        backgroundImage: MemoryImage(img!)
                      ),
                    ],
                  ),
                  width: 80,
                  height: 80,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              postData.fullName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.more_horiz)
                          ],
                        ),
                        Text(
                          getTimeDifference(postData.timesTamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              children: [Text(postData.details)], // ใช้ข้อมูล details จาก postData
            ),
          ),
        ],
      );
  }

  Future<Widget> buildPostImageAPI(String id) async {
    late List<Uint8List> imageBytesList;
    
    bool isImage(String fileName) {
      final lowercaseFileName = fileName.toLowerCase();
      return lowercaseFileName.endsWith('.png') ||
          lowercaseFileName.endsWith('.jpg') ||
          lowercaseFileName.endsWith('.jpeg') ||
          lowercaseFileName.endsWith('.gif') ||
          lowercaseFileName.endsWith('.webp');
    }

    final response = await http.get(Uri.parse('http://10.98.0.51:8081/Api/Community/images/$id')); // ระบุ URL ของ API ที่ให้ไฟล์ zip
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final archive = ZipDecoder().decodeBytes(bytes); // แยกไฟล์ zip

      List<Uint8List> images = [];
      for (final file in archive) {
        final data = file.content as List<int>;

        // ตรวจสอบว่าไฟล์เป็นภาพหรือไม่
        if (isImage(file.name)) {
          images.add(Uint8List.fromList(data));
        }
      }

      imageBytesList = images;
      return Container(
        height: imageBytesList.isNotEmpty ? 350 : 0,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: imageBytesList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 200, // กำหนดความกว้างตามที่ต้องการ
              child: Image.memory(imageBytesList[index]),
            );
          },
        ),
      );
    } else {
      //throw Exception('Failed to load zip file');
      return Container(
        height: 0,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              child: Image.memory(imageBytesList[index]),
            );
          },
        ),
      );
    }
  }

  Widget buildCommentRow(String id) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20, bottom: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // children: [Text("2 comments")],
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(Post(id : id));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0, color: Color(0xFFE5E5E5)))),
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.comment_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Comment",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        )
      ],
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

class PostData {
  final String idCommunity;
  final String idUser;
  final String fullName;
  final String category;
  final String details;
  final String timesTamp;

  PostData({
    required this.idCommunity,
    required this.idUser,
    required this.fullName,
    required this.category,
    required this.details,
    required this.timesTamp,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      idCommunity: json['idCommunity'] ?? '',
      idUser: json['idUser'] ?? '',
      fullName: json['fullName'] ?? '',
      category: json['category'] ?? '',
      details: json['details'] ?? '',
      timesTamp: json['timesTamp'] ?? '',
    );
  }
}