import 'package:dorm_app/src/pages/bar_graph/individual_bar.dart';

class BarData {
  final double janAmount;
  final double febAmount;
  final double marchAmount;
  final double aprilAmount;
  final double mayAmount;
  final double juneAmount;
  final double julyAmount;
  final double augAmount;
  final double sepAmount;
  final double octAmount;
  final double novAmount;
  final double decAmount;

  BarData({
    required this.janAmount,
    required this.febAmount,
    required this.marchAmount,
    required this.aprilAmount,
    required this.mayAmount,
    required this.juneAmount,
    required this.julyAmount,
    required this.augAmount,
    required this.sepAmount,
    required this.octAmount,
    required this.novAmount,
    required this.decAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: janAmount),
      IndividualBar(x: 1, y: febAmount),
      IndividualBar(x: 2, y: marchAmount),
      IndividualBar(x: 3, y: aprilAmount),
      IndividualBar(x: 4, y: mayAmount),
      IndividualBar(x: 5, y: juneAmount),
      IndividualBar(x: 6, y: julyAmount),
      IndividualBar(x: 7, y: augAmount),
      IndividualBar(x: 8, y: sepAmount),
      IndividualBar(x: 9, y: octAmount),
      IndividualBar(x: 10, y: novAmount),
      IndividualBar(x: 11, y: decAmount),
    ];
  }
}