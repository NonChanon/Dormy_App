import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPayment extends StatelessWidget {
  final String qrContent;

  const QRPayment({Key? key, required this.qrContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("QR Payment"),
          elevation: 2,
          shadowColor: Colors.black,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          height: 550,
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
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(
                          bottom: 15, top: 15, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Text('ROOM101 - MARCH/2023',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ))
                  ],
                ),
                SizedBox(height: 40),
                // ใช้ QrImage จากแพ็กเกจ qr_flutter เพื่อแสดง QR Code
                QrImageView(
                  data: qrContent,
                  version: QrVersions.auto,
                  size: 300.0,
                ),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
        ));
  }
}
