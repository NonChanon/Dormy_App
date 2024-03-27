import 'dart:convert';
import 'package:dorm_app/src/pages/report.dart';
import 'package:http/http.dart' as http;
import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewReportPage extends StatefulWidget {
  const NewReportPage({Key? key}) : super(key: key);

  @override
  State<NewReportPage> createState() => _NewReportPageState();
}

class _NewReportPageState extends State<NewReportPage> {

  final AuthController _authController = Get.put(AuthController());
  String? _selectedValue;
  final _detailsController = TextEditingController();
  final _categoryController = TextEditingController();

  void sendReport() async {
    final id = _authController.getIduser();
    final reqBody = {
      "idUser" : id,
      "details" : _detailsController.text,
      "category" : _categoryController.text,
      "title" : "text"
    };
    final reqBodyNoitfy = {
      "idUser" : id,
      "details" : _detailsController.text,
      "title" : _categoryController.text
    };
    await http.post(Uri.parse('http://10.98.0.51:8081/Api/Notify/CreateNotifyReport'),headers: {"Content-Type":"application/json"},body : jsonEncode(reqBodyNoitfy));
    final response = await http.post(Uri.parse('http://10.98.0.51:8081/Api/Problem/CreateProblem'),headers: {"Content-Type":"application/json"},body : jsonEncode(reqBody));
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
                  Navigator.of(context).pop();
                  Get.to(ReportPage()); 
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("New Report"),
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
              _buildHeader(_authController.getRoomName()),
              DropdownWidget(
                selectedValue: _selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    _selectedValue = value;
                    _categoryController.text = value ?? '';
                  });
                },
              ),
              _buildDetail(),
              _buildAddReport(),
              // _buildAnonymousMode(),
              // _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String roomName) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        "Room " + roomName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
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
          hintText: 'Write a detail...',
        ),
        maxLines: 5,
      ),
    );
  }

  Widget _buildAddReport() {
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // IconButton(
          //   icon: (Icon(
          //     Icons.photo_camera,
          //     size: 32,
          //   )),
          //   onPressed: () {},
          // ),
          Spacer(),
          ElevatedButton(
            onPressed: sendReport,
            child: Text('DONE'),
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
    return DropdownButton<String>(
      padding: EdgeInsets.all(10),
      value: selectedValue,
      onChanged: onChanged,
      hint: Text('Topic'),
      items: <String>['Electricity', 'Water', 'Internet', 'Room', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
