import 'package:flutter/material.dart';

class NewReportPage extends StatefulWidget {
  const NewReportPage({Key? key}) : super(key: key);

  @override
  State<NewReportPage> createState() => _NewReportPageState();
}

class _NewReportPageState extends State<NewReportPage> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFb7b7b7),
                blurRadius: 2.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              DropdownWidget(
                selectedValue: _selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    _selectedValue = value;
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
}

Widget _buildHeader() {
  return Container(
    padding: EdgeInsets.all(10),
    child: Text(
      'Room 101',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    ),
  );
}

Widget _buildDetail() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextField(
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
            onPressed: () {},
          ),
          ElevatedButton(
            onPressed: () {},
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
      ));
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
