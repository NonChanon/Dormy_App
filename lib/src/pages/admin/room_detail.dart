import 'package:dorm_app/src/pages/invoice_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomDetailPage extends StatelessWidget {
  const RoomDetailPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: RoomDetailAppBar(),
      body: RoomDetailList(),
    );
  }
}

class RoomDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text("Room Detail"),
      elevation: 5,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
    );
  }
}

class RoomDetailList extends StatefulWidget {
  @override
  _RoomDetailListState createState() => _RoomDetailListState();
}

class _RoomDetailListState extends State<RoomDetailList> {
  String _selectedMenu = "Renter";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
          ),
          padding: EdgeInsets.only(bottom: 20),
          margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _filterMenu("Renter"),
                SizedBox(width: 10),
                _filterMenu("Lease"),
                SizedBox(width: 10),
                _filterMenu("Payment History"),
                SizedBox(width: 10),
                _filterMenu("Report History"),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 10), // เพิ่ม Padding ที่ต้องการให้ห่างจากขอบซ้าย
          child: Text(_selectedMenu,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: _buildSelectedMenuWidget(), // เรียกใช้งาน Widget ที่ถูกเลือก
        ),
      ],
    );
  }

  // Widget สำหรับแสดงตามเมนูที่เลือก
  Widget _buildSelectedMenuWidget() {
    switch (_selectedMenu) {
      case "Renter":
        return buildRenterRow();
      case "Lease":
        return buildLeaseContainer();
      case "Payment History":
        return buildInvoiceContainer();
      case "Report History":
        return ReportItem();
      default:
        return Container(); // สำหรับกรณีเมนูไม่ถูกต้อง
    }
  }

  Widget _filterMenu(String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedMenu =
              label; // เมื่อเมนูถูกเลือกใหม่ ให้เปลี่ยนค่าตัวแปรเพื่อเลือกเมนู
        });
      },
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: _selectedMenu == label
                ? Color(0xFFE5E5E5) // ให้สลับสีเมื่อถูกเลือก
                : Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: Text(label),
        ),
      ),
    );
  }
}

Widget buildRenterRow() {
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
            color: Color(0xFFb7b7b7), blurRadius: 2.0, offset: Offset(0, 5)),
      ],
    ),
    child: Row(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
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
            child: buildRenterDetails(),
          ),
        )
      ],
    ),
  );
}

Widget buildRenterDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Chanon Kitbunnadaech",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(
        height: 2,
      ),
      Container(
          width: 120,
          padding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Color(0xFFFDCD34),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Icon(
                Icons.phone,
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "00000555040",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          )),
      SizedBox(
        height: 2,
      ),
      Text(
        "Join Dormitory since 20/2/2023",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget buildLeaseContainer() {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
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
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 10, left: 20, top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rental Invoice Febuary/2024",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildInvoiceContainer() {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
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
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(InvoiceDetail());
            },
            child: Container(
              padding:
                  EdgeInsets.only(right: 10, left: 20, top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rental Invoice Febuary/2024",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Paid",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.keyboard_arrow_right_outlined)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

class ReportItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 80,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0xFFb7b7b7), blurRadius: 2.0, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.newspaper, size: 34),
              ],
            ),
            width: 80,
            height: 80,
            color: Colors.amber,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Report",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("has been received."),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "12 hours ago",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
