import 'dart:ffi';

import 'package:dorm_app/%E0%B8%B5%E0%B8%B5utils/authController.dart';
import 'package:dorm_app/src/pages/bar_graph/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class BarGraph extends StatelessWidget {
  final List yearSummary;
  const BarGraph({
    super.key,
    required this.yearSummary,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.find();
    UserRole userRole = _authController.getCurrentUserRole();
    double maxY = 0;
    switch (userRole) {
      case UserRole.admin:
        maxY = 80000;
        break;
      case UserRole.user:
        maxY = 7000;
        break;
    }
    BarData myBarData = BarData(
      janAmount: yearSummary[0],
      febAmount: yearSummary[1],
      marchAmount: yearSummary[2],
      aprilAmount: yearSummary[3],
      mayAmount: yearSummary[4],
      juneAmount: yearSummary[5],
      julyAmount: yearSummary[6],
      augAmount: yearSummary[7],
      sepAmount: yearSummary[8],
      octAmount: yearSummary[9],
      novAmount: yearSummary[10],
      decAmount: yearSummary[11],
    );
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTiles))),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                      color: Color(0xFFFDCD34),
                      toY: data.y,
                      width: 15,
                      borderRadius: BorderRadius.circular(2),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 50,
                        color: Colors.grey[200],
                      )),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Jan',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'Feb',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Mar',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Apr',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'May',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'Jun',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Jul',
        style: style,
      );
      break;
    case 7:
      text = const Text(
        'Aug',
        style: style,
      );
      break;
    case 8:
      text = const Text(
        'Sep',
        style: style,
      );
      break;
    case 9:
      text = const Text(
        'Oct',
        style: style,
      );
      break;
    case 10:
      text = const Text(
        'Nov',
        style: style,
      );
      break;
    case 11:
      text = const Text(
        'Dec',
        style: style,
      );
      break;
    default:
      text = const Text(
        'Dec',
        style: style,
      );
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
 main
