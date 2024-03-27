import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/bar_graph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthController _authController = Get.find();
  List<double> yearSummary = [
    62000,
    65000,
    70000,
    72000,
    55000,
    57000,
    52000,
    64000,
    65000,
    62000,
    63000,
    61250
  ];

  List<double> yearUserSummary = [
    5200,
    5450,
    6100,
    6000,
    5050,
    5000,
    5100,
    5600,
    5380,
    5190,
    5287,
    5308
  ];

  Map<String, double> dataMap = {
    "Room Fee": 33,
    "Water Fee": 10,
    "Electric Fee": 17,
    "Other": 6,
    "Unpaid": 33,
  };

  Map<String, double> dataUserMap = {
    "Room Fee": 62,
    "Water Fee": 10,
    "Electric Fee": 20,
    "Other": 8,
  };

  List<Color> colorList = [
    Colors.green,
    Colors.blue,
    Color(0xFFFDCD34),
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    UserRole userRole = _authController.getCurrentUserRole();
    Widget currentUser;
    switch (userRole) {
      case UserRole.admin:
        currentUser = dashboardAdminBody();
        break;
      case UserRole.user:
        currentUser = dashboardUserBody();
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Dashboard"),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
      ),
      body: currentUser,
    );
  }

  Widget dashboardUserBody() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Summary of dormitory expenses",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "from January to December 2023",
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 40),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0,
                ),
              ),
            ),
            child: SizedBox(
              height: 200,
              child: BarGraph(
                yearSummary: yearUserSummary,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Analyze monthly expenses",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "December / 2023",
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          PieChart(
            dataMap: dataUserMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 60,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Total amount : 5,308 Bath",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget dashboardAdminBody() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Summary of dormitory rental income",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "from January to December 2023",
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 40),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0,
                ),
              ),
            ),
            child: SizedBox(
              height: 200,
              child: BarGraph(
                yearSummary: yearSummary,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Analyze monthly rental income",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "December / 2023",
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 60,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Total amount : 61,250 Bath",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
