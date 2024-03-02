import 'package:flutter/material.dart';

class Meter extends StatefulWidget {
  const Meter({Key? key});

  @override
  State<Meter> createState() => _MeterState();
}

class _MeterState extends State<Meter> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this); // กำหนดจำนวนแท็บเป็น 2
    super.initState();
  }

  void dispose() {
    _tabController.dispose(); // จัดการคืนทรัพยากร
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Meter"),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Container(
          height: 245,
          child: PageView.builder(
            itemCount: 1,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: _tabBar(),
        ),
        Expanded(
          // เพิ่ม Expanded ที่ครอบ TabBarView
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            height: MediaQuery.of(context).size.height -
                245, // กำหนดความสูงให้เป็นความสูงที่เหลือจาก MediaQuery
            child: TabBarView(
              controller: _tabController,
              children: [
                // เนื้อหาของแท็บที่ 1
                _tabBarBody(),
                // เนื้อหาของแท็บที่ 2
                Center(child: Text('Tab 2 content')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    return Stack(
      children: [
        Container(
          height: 200,
          color: Colors.black,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 40, right: 40, top: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xFFFDCD34),
            ),
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1, color: Colors.black)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.apartment, size: 26),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              'Happy Apartmentssss',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'Building Happy',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 40,
            width: 120,
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xFFFDCD34),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.location_on_outlined, size: 26),
                Text(
                  '1st Floor',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          left: 40,
          right: 40,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search room number...",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _filterMenu(String label) {
    return Container(
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: Text(label),
        ),
      ]),
    );
  }

  Widget _tabBar() {
    return Column(
      children: [
        TabBar(
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          controller: _tabController, // ใช้ TabController ที่สร้างไว้
          tabs: [
            Tab(
              icon: Icon(Icons.electric_bolt),
              // text: 'Electric',
            ), // แท็บที่ 1
            Tab(
              icon: Icon(Icons.water_drop),
              // text: 'Water',
            ), // แท็บที่ 2
          ],
        ),
      ],
    );
  }

  Widget _tabBarBody() {
    return SingleChildScrollView(
        child: Table(
      border: TableBorder.symmetric(
        outside: BorderSide.none,
      ),
      columnWidths: {
        0: FlexColumnWidth(1), // "Room" column width
        1: FlexColumnWidth(2), // "Last month" column width
        2: FlexColumnWidth(2), // "This month" column width
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xFFD5D5D5)),
            ),
          ),
          children: [
            TableCell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Center(
                  child: Text('Room',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Center(
                  child: Text('Last month',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Center(
                  child: Text('This month',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Center(
                  child: Text('A101', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: TextFormField(
                    enabled: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Center(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Meter number',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    )
        // child: DataTable(
        //   columnSpacing: 100,
        //   columns: const <DataColumn>[
        //     DataColumn(
        //       label: Text(
        //         'Name',
        //         style: TextStyle(),
        //       ),
        //     ),
        //     DataColumn(
        //       label: Text(
        //         'Age',
        //         style: TextStyle(),
        //       ),
        //     ),
        //     DataColumn(
        //       label: Text(
        //         'Role',
        //         style: TextStyle(),
        //       ),
        //     ),
        //   ],
        //   rows: const <DataRow>[
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Janine')),
        //         DataCell(Text('43')),
        //         DataCell(Text('Professor')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('William')),
        //         DataCell(Text('27')),
        //         DataCell(Text('Associate')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Sarah')),
        //         DataCell(Text('19')),
        //         DataCell(Text('Student')),
        //       ],
        //     ),
        //   ],
        // ),
        );
  }
}
