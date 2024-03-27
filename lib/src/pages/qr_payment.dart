import 'dart:convert';

import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/component/invoice_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';
import 'package:http/http.dart' as http;


class QRPayment extends StatelessWidget {
  final double amount;
  final String idInvoice;
  const QRPayment({Key? key, required this.idInvoice, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final AuthController _authController = Get.put(AuthController());
  final months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  sendPayment() async {
    final idInvoice = this.idInvoice;
    final idUser = _authController.getIduser();
    await http.post(Uri.parse('http://10.98.0.51:8081/Api/Notify/CreateNotifyPayment/$idUser'));
    final response = await http.put(Uri.parse('http://10.98.0.51:8081/Api/Invoice/Payment/$idInvoice'));
    if(response.statusCode >= 200 && response.statusCode < 300){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payment'),
            content: Text("Successful"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
  

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text("Room " +_authController.getRoomName()),
      elevation: 2,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
    ),
    body: Container(
      margin: EdgeInsets.only(top: 30, left: 10, right: 10),
      height: 560,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0xFFb7b7b7),
              blurRadius: 2.0,
              offset: Offset(0, 5)),
        ],
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              SizedBox(height: 10),
            // ใช้ QrImage จากแพ็กเกจ qr_flutter เพื่อแสดง QR Code
            Container(
              child: QRCodeGenerate(
                promptPayId: "0648791262",
                isShowAccountDetail: false,
                isShowAmountDetail: false,
                amount: this.amount,
                width: 400,
                height: 400,
              ),
            ),
            // QrImageView(
            //   data: qrContent,
            //   version: QrVersions.auto,
            //   size: 300.0,
            // ),
            SizedBox(height: 20),
            Text(
              'Scan QR Code to make payment',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {Get.back();},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE6E6E6),
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // ปรับความโค้งของมุม
                      ),
                    ),
                    child: Text("CANCEL",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {sendPayment();},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFDCD34),
                      padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                        borderRadius:
                          BorderRadius.circular(5), // ปรับความโค้งของมุม
                      ),
                    ),
                    child: Text("DONE",
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}