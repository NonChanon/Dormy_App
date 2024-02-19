import 'package:flutter/material.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  return Row(
    children: [
      CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/image/roomTest.jpg'),
      ),
      const SizedBox(width: 10),
      Text(
        'Nattanicha',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ],
  );
}

Widget _buildDetail() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Your Post...',
      ),
      maxLines: 5,
    ),
  );
}

Widget _buildAddImage() {
  return Container(
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
        child: const Text('POST'),
      ),
    ],
  ));
}

// Widget _buildAnonymousMode() {
//   return Row(
//     children: [
//       Checkbox(value: false, onChanged: (value) {}),
//       const Text('Anonymous Mode'),
//       const SizedBox(width: 10),
//     ],
//   );
// }

// Widget _buildButtons() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       const SizedBox(width: 10),
//       ElevatedButton(
//         onPressed: () {},
//         child: const Text('POST'),
//       ),
//     ],
//   );
// }

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
      hint: Text('Post to'),
      items: <String>['Public', 'My Apartment', 'Anouncement']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
