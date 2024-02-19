import 'package:flutter/material.dart';

class MyApartmentBody extends StatefulWidget {
  const MyApartmentBody({Key? key}) : super(key: key);

  @override
  State<MyApartmentBody> createState() => _MyApartmentBodyState();
}

class _MyApartmentBodyState extends State<MyApartmentBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: buildApartmentDetails(),
      ),
    );
  }

  Widget buildApartmentDetails() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle("Apartment Detail"),
          buildDetailRow(Icons.home, "Happy Apartment", "A101"),
          buildDetailRow(
              Icons.location_on, "Address", "123/4 Ladkrabang, Bangkok"),
          SizedBox(height: 15),
          buildSectionTitle("Contact"),
          buildDetailRow(Icons.phone, "Phone No.", "0123456789"),
          buildDetailRow(Icons.email, "E-Mail", "ab23@mail.com"),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String title, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
      ),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(100),
            ),
            width: 50,
            height: 50,
            child: Icon(icon, size: 30),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
