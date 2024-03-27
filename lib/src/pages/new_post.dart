import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/component/community_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {

  final AuthController _authController = Get.put(AuthController());
  String? _selectedValue;
  final _detailsController = TextEditingController();
  final _categoryController = TextEditingController();

  List<XFile> images = [];

  Future<void> pickImages() async {
    List<XFile> pickedImages = [];
    try {
      pickedImages = await ImagePicker().pickMultiImage(
        maxWidth: 800, // กำหนดความกว้างสูงสุดของรูปภาพที่เลือก
        maxHeight: 800, // กำหนดความสูงสูงสุดของรูปภาพที่เลือก
        imageQuality: 70, // กำหนดคุณภาพของรูปภาพที่เลือก (0-100)
      );
    } catch (e) {
      print('Error: $e');
    }

    if (!mounted) return;

    setState(() {
      images = pickedImages;
    });
  }

  void sendReport() async {
    final id = _authController.getIduser();
    late String category = "public"; // ประกาศตัวแปร category และกำหนดค่าเริ่มต้นเป็น "public"
    if (_categoryController.text == "Public") {
      category = "public"; // ถ้า _categoryController.text เท่ากับ "Public" ให้กำหนดค่า category เป็น "public"
    } else if (_categoryController.text == "My Apartment") {
      category = "apartment"; // ถ้า _categoryController.text เท่ากับ "My Apartment" ให้กำหนดค่า category เป็น "apartment"
    } else if (_categoryController.text == "Anouncement") {
      category = "announcement"; // ถ้า _categoryController.text เท่ากับ "Announcement" ให้กำหนดค่า category เป็น "announcement"
    }

    final reqBody = {
      "idUser" : id,
      "details" : _detailsController.text,
      "category" : category,
    };

    final response = await http.post(Uri.parse('http://10.98.0.51:8081/Api/Community/CreatePost'),headers: {"Content-Type":"application/json"},body : jsonEncode(reqBody));
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
                  Navigator.of(context).pop();

                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<Uint8List> fetchImageBytes() async {
    final id = _authController.getIduser();
    final response = await http.get(Uri.parse('http://10.98.0.51:8081/Api/User/getProFile/$id'));

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("New Post"),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFb7b7b7),
                blurRadius: 2.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              DropdownWidget(
                selectedValue: _selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    _selectedValue = value;
                    _categoryController.text = value ?? 'public';
                  });
                },
              ),
              _buildDetail(),
              _buildAddImage(),
              // _buildAnonymousMode(),
              // _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FutureBuilder(
      future: fetchImageBytes(), // เรียกใช้ฟังก์ชันเพื่อเรียกข้อมูลภาพ
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // แสดง Indicator ขณะโหลดข้อมูล
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // แสดงข้อความ Error หากเกิดข้อผิดพลาด
        }
        final img = snapshot.data; // รับข้อมูลภาพจาก snapshot
        return Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: MemoryImage(snapshot.data!),
            ),
            const SizedBox(width: 10),
            Text(
              _authController.getFullName(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetail() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _detailsController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: 'Your Post...',
        ),
        maxLines: 5,
      ),
    );
  }

  Widget _buildAddImage() {
    return Container(
        padding: EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: (Icon(
                Icons.photo_camera,
                size: 32,
              )),
              onPressed: () {
                pickImages();
              },
            ),
            ElevatedButton(
              onPressed: () {
                sendReport();
              },
              child: Text('POST'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        )
    );
  } 
}



class DropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final void Function(String?)? onChanged;

  const DropdownWidget({
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(AuthController());
    List<String> dropDownItems = [];
    final UserRole userRole = _authController.getCurrentUserRole();
    if (userRole == UserRole.admin) {
      dropDownItems = ['Public', 'My Apartment', 'Anouncement'];
    } else {
      dropDownItems = ['Public', 'My Apartment'];
    }

    return DropdownButton<String>(
      padding: EdgeInsets.all(10),
      value: selectedValue,
      onChanged: onChanged,
      hint: Text('Post to'),
      items: dropDownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
