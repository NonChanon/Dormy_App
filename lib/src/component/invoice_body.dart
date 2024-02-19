import 'package:flutter/material.dart';

class InvoiceBody extends StatefulWidget {
  const InvoiceBody({super.key});

  @override
  State<InvoiceBody> createState() => _InvoiceBodyState();
}

class _InvoiceBodyState extends State<InvoiceBody>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                buildInvoiceListView(isPaid: false),
                buildInvoiceListView(isPaid: true),
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

  Widget buildInvoiceListView({required bool isPaid}) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return buildInvoiceContainer(isPaid: isPaid);
      },
    );
  }

  Widget buildInvoiceContainer({required bool isPaid}) {
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
}
