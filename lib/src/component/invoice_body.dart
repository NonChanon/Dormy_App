import 'dart:convert';

import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/invoice_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InvoiceBody extends StatefulWidget {
  const InvoiceBody({super.key});

  @override
  State<InvoiceBody> createState() => _InvoiceBodyState();
}

class _InvoiceBodyState extends State<InvoiceBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final AuthController _authController = Get.put(AuthController());
  final invoicePaid = <Invoice>[].obs;
  final invoiceUnpaid = <Invoice>[].obs;
  final months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchGetInvoice();
  }

  fetchGetInvoice() async {
    final idRoom = _authController.getIdRoom();
    var response = await http.get(Uri.parse("http://10.98.0.51:8081/Api/Invoice/GetInvoicesHistory/$idRoom"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (var data in jsonResponse) {
        if(data["status"]) invoicePaid.add(Invoice.fromJson((data)));
        else invoiceUnpaid.add(Invoice.fromJson((data)));
      }
      print("invoicePaid : " + invoicePaid.length.toString());
      print("invoiceUnpaid : " + invoiceUnpaid.length.toString());
      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildInvoiceListView(length : invoiceUnpaid.length,type : "Unpaid"),
                buildInvoiceListView(length : invoicePaid.length,type : "Paid"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(top: 5),
      color: Color(0xFFFDCD34),
      child: TabBar(
        unselectedLabelColor: Color(0xFF444444),
        labelColor: Colors.black,
        indicatorColor: Colors.black,
        controller: _tabController,
        tabs: [
          Tab(text: 'Invoice', icon: Icon(Icons.receipt)),
          Tab(text: 'History', icon: Icon(Icons.history)),
        ],
      ),
    );
  }

  Widget buildInvoiceListView({required int length,required String type}) {

    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: length,
      itemBuilder: (context, index) {
        return buildInvoiceContainer(invoice : type == "Unpaid" ? invoiceUnpaid[index] : invoicePaid[index]);
      },
    );
  }

  Widget buildInvoiceContainer({required Invoice invoice}) {
    
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InvoiceDetail(invoice : invoice)));
              },
              child: Container(
                padding:
                    EdgeInsets.only(right: 10, left: 20, top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rental Invoice "+ months[invoice.timesTamp.month] +" / "+invoice.timesTamp.year.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Row(children: [
                            invoice.status
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
                            invoice.status
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
          ),
        ],
      ),
    );
  }
}

class Invoice {
  final String idInvoice;
  final String idRoom;
  final String roomName;
  final int roomPrice;
  final int electricityPrice;
  final int waterPrice;
  final int electricityUnit;
  final int waterUnit;
  final int furniturePrice;
  final int internetPrice;
  final int parkingPrice;
  final int other;
  final int total;
  final bool status;
  final bool statusShow;
  final DateTime dueDate;
  final DateTime timesTamp;

  Invoice({
    required this.idInvoice,
    required this.idRoom,
    required this.roomName,
    required this.roomPrice,
    required this.electricityPrice,
    required this.waterPrice,
    required this.electricityUnit,
    required this.waterUnit,
    required this.furniturePrice,
    required this.internetPrice,
    required this.parkingPrice,
    required this.other,
    required this.total,
    required this.status,
    required this.statusShow,
    required this.dueDate,
    required this.timesTamp,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      idInvoice: json['idInvoice'] ?? '',
      idRoom: json['idRoom'] ?? '',
      roomName: json['roomName'].toString() ?? '',
      roomPrice: json['roomPrice'] ?? 0,
      electricityPrice: json['electricityPrice'] ?? 0,
      waterPrice: json['waterPrice'] ?? 0,
      electricityUnit: json['electricityUnit'] ?? 0,
      waterUnit: json['waterUnit'] ?? 0,
      furniturePrice: json['furniturePrice'] ?? 0,
      internetPrice: json['internetPrice'] ?? 0,
      parkingPrice: json['parkingPrice'] ?? 0,
      other: json['other'] ?? 0,
      total: json['total'] ?? 0,
      status: json['status'] ?? false,
      statusShow: json['statusShow'] ?? false,
      dueDate: DateTime.parse(json['dueDate']),
      timesTamp: DateTime.parse(json['timesTamp']),
    );
  }
}
