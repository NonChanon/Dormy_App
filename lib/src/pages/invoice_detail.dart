import 'package:flutter/material.dart';

class InvoiceDetail extends StatefulWidget {
  const InvoiceDetail({Key? key}) : super(key: key);

  @override
  State<InvoiceDetail> createState() => _InvoiceDetailState();
}

class _InvoiceDetailState extends State<InvoiceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("Room A101"),
          elevation: 5,
          shadowColor: Colors.black,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          )),
      body: Container(
        color: Colors.white,
        child: buildApartmentDetails(),
      ),
    );
  }

  Widget buildApartmentDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle("Apartment Detail"),
          buildSectionStatus(false),
          buildDetailRow(Icons.home, "Happy Apartment", "A101"),
          buildPaymentButton(false)
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.only(bottom: 15, top: 15, left: 20, right: 20),
          color: Color(0xFFFDCD34),
          child: Text(
            'Rental Invoice March/2023',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ))
      ],
    );
  }

  Widget buildSectionStatus(bool isPaid) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Invoice Status",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Container(
                  child: Row(
                    children: [
                      Row(children: [
                        isPaid
                            ? Icon(
                                Icons.check_circle_outline,
                                size: 20,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.pending_actions_outlined,
                                size: 20,
                                color: Color(0xFFF4A64A),
                              ),
                        SizedBox(
                          width: 2,
                        ),
                        isPaid
                            ? Text(
                                "Paid",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "Unpaid",
                                style: TextStyle(
                                    color: Color(0xFFF4A64A),
                                    fontWeight: FontWeight.bold),
                              ),
                      ]),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildDetailRow(IconData icon, String title, String value) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
              padding:
                  EdgeInsets.only(bottom: 15, top: 15, left: 20, right: 20),
              color: Colors.black,
              child: Text(
                'LIST',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ))
          ],
        ),
        ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Room Fee',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '฿ 3,000',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildPaymentButton(bool isPaid) {
    if (!isPaid) {
      return InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(20),
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFFDCD34),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              'MAKE PAYMENT',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else {
      return Container(); // ถ้าเป็น True ไม่ต้องแสดงปุ่มเลย ให้ส่งคืน Container ว่าง
    }
  }
}
