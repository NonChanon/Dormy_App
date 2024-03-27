import 'dart:convert';
import 'dart:typed_data';

import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';

class Post extends StatefulWidget {

  final String id;

  const Post({Key? key, required this.id}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final AuthController _authController = Get.put(AuthController());
  final _commentController = TextEditingController();

  PostData? _post;
  final _comments = <CommentData>[];

  fetchPostData() async {
    final id = widget.id;
    final response = await http.get(Uri.parse("http://10.98.0.51:8081/Api/Community/GetPost/$id"));
    if (response.statusCode == 200) {
      // ถ้าสำเร็จ ส่งค่ากลับในรูปแบบของ PostData
      _post =  PostData.fromJson(json.decode(response.body));
    } else {
      // ถ้าเกิดข้อผิดพลาด ส่งค่าเป็น null
      throw Exception('Failed to load post data');
    }
  }

  fetchCommentData() async {
    final id = widget.id;
    final response = await http.get(Uri.parse("http://10.98.0.51:8081/Api/Comment/GetAllComment/$id"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _comments.clear();
      List<CommentData> comments = [];
      for (var data in jsonResponse) {
        comments.add(CommentData.fromJson(data));
      }
      setState(() {_comments.addAll(comments);});
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

  void sendComment() async {
    
    final reqBody = {
      "idCommunity": widget.id,
      "idUser" : _authController.getIduser(),
      "details" : _commentController.text,
    };

    final response = await http.post(Uri.parse('http://10.98.0.51:8081/Api/Comment/CreateComment'),headers: {"Content-Type":"application/json"},body : jsonEncode(reqBody));
    if(response.statusCode >= 200 && response.statusCode < 300){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Report'),
            content: Text("Successful"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  fetchCommentData();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPostData();
    fetchCommentData();
    print("ID : " + widget.id);
  }

  @override
  Widget build(BuildContext context) {

    final String id = widget.id;
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
          FutureBuilder<Widget>(
            future: buildPostImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return snapshot.data!;
            },
          ),
          buildCommentRow(),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildUserRow() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder<Uint8List>(
          future: fetchImageBytes(_post?.idUser ?? ''), // แทน postData.idUser ด้วยข้อมูลที่เหมาะสม
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // ในกรณีที่กำลังโหลดข้อมูล
              return CircularProgressIndicator(); // หรือ Widget อื่นๆ ที่ต้องการแสดงระหว่างโหลดข้อมูล
            } else if (snapshot.hasError) {
              // ในกรณีที่เกิดข้อผิดพลาดในการโหลดข้อมูล
              return Text('Error: ${snapshot.error}');
            } else {
              // ในกรณีที่โหลดข้อมูลเสร็จสมบูรณ์
              return Container(
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: MemoryImage(snapshot.data!) // ใช้รูปภาพที่โหลดมาจาก snapshot.data
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
          },
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
              _post?.fullName ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.more_horiz)
          ],
        ),
        Text(
          getTimeDifference(_post?.timesTamp ?? ''),
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
        children: [Text(_post?.details ?? '')],
      ),
    );
  }

  Future<Widget> buildPostImage() async {
    late List<Uint8List> imageBytesList;
    
    bool isImage(String fileName) {
      final lowercaseFileName = fileName.toLowerCase();
      return lowercaseFileName.endsWith('.png') ||
          lowercaseFileName.endsWith('.jpg') ||
          lowercaseFileName.endsWith('.jpeg') ||
          lowercaseFileName.endsWith('.gif') ||
          lowercaseFileName.endsWith('.webp');
    }
    final id = widget.id;
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

  Widget buildCommentRow() {
    return Column(
      children: [
        InkWell(
          // onTap: () {
          //   Get.to(Post(id:"TEST"));
          // },
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
                  width: 340,
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
                            color: const Color.fromARGB(255, 124, 124, 124)
                          )
                        ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send_rounded),
                  onPressed: () {
                    sendComment(); // เรียกใช้ฟังก์ชันเมื่อผู้ใช้คลิกที่ปุ่มส่งความคิดเห็น
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildListView() {

    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _comments.length,
      itemBuilder: (context, index) {
        return buildReplyRow(_comments[index]);
      },
    );
  }

  Widget buildReplyRow(CommentData comment) {
    return FutureBuilder(
      future: fetchImageBytes(comment.idUser), // เรียกใช้ฟังก์ชันเพื่อโหลดรูปภาพ
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // แสดง Indicator ระหว่างโหลดรูปภาพ
        } else if (snapshot.hasError) {
          return Text('Error loading image'); // แสดงข้อความหากมีข้อผิดพลาดในการโหลดรูปภาพ
        } else {
          // สร้าง CircleAvatar ด้วยรูปภาพที่โหลดเสร็จสิ้น
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
                            backgroundImage: MemoryImage(snapshot.data!), // ใช้รูปภาพที่โหลดเสร็จสิ้น
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  comment.fullName ?? '',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Text(
                              comment.details ?? '',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
      },
    );
  }

}

String getTimeDifference(String timeStamp) {
  if(timeStamp != '')
  {
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
  return "Time Error";
  
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

class CommentData {
  final String idComment;
  final String idCommunity;
  final String idUser;
  final String fullName;
  final String details;
  final String timesTamp;

  CommentData({
    required this.idComment,
    required this.idCommunity,
    required this.idUser,
    required this.fullName,
    required this.details,
    required this.timesTamp,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      idComment: json['idComment'] ?? '',
      idCommunity: json['idCommunity'] ?? '',
      idUser: json['idUser'] ?? '',
      fullName: json['fullName'] ?? '',
      details: json['details'] ?? '',
      timesTamp: json['timesTamp'] ?? '',
    );
  }
}