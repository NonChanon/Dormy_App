
import 'dart:typed_data';
import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/qr_payment.dart';

import 'package:flutter/material.dart';
import 'package:dorm_app/src/component/invoice_body.dart';
import 'package:get/get.dart';
import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';

class InvoiceDetail extends StatefulWidget {
  final Invoice invoice; // รับ Invoice เป็นอาร์กิวเมนต์
  const InvoiceDetail({Key? key, required this.invoice}) : super(key: key);

  @override
  State<InvoiceDetail> createState() => _InvoiceDetailState();
}

class _InvoiceDetailState extends State<InvoiceDetail> {

  final AuthController _authController = Get.put(AuthController());
  final months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Room " + _authController.getRoomName()),
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
          buildSectionTitle(),
          buildSectionStatus(widget.invoice.status),
          buildDetailRow(),
          buildPaymentButton(widget.invoice.status)
        ],
      ),
    );
  }

  Widget buildSectionTitle() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.only(bottom: 15, top: 15, left: 20, right: 20),
          color: Color(0xFFFDCD34),
          child: Text(
            "Rental Invoice " + months[widget.invoice.timesTamp.month] +" / "+ widget.invoice.timesTamp.year.toString(),
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

  Widget buildDetailRow() {
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
          itemCount: 7,
          itemBuilder: (context, index) {
            return buildDetailItem(index);
          },
        ),
      ],
    );
  }

  Widget buildDetailItem(int index) {
    final titleFee = ['Room fee', 'Furniture fee', 'Internet fee', 'Parking fee', 'Electricity fee', 'Water fee', 'Total'];
    final iv = widget.invoice;
    final fee = [iv.roomPrice.toString(),iv.furniturePrice.toString(),iv.internetPrice.toString(),iv.parkingPrice.toString(), iv.electricityPrice.toString(),
    iv.waterPrice.toString(),iv.total.toString()];
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleFee[index],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            fee[index],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentButton(bool isPaid) {
    if (!isPaid) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRPayment(
                idInvoice : widget.invoice.idInvoice,
                amount : widget.invoice.total.toDouble(),

              ),
            ),
          );
        },
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

