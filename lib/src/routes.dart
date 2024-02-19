import 'package:dorm_app/src/pages/Invoice.dart';
import 'package:dorm_app/src/pages/community.dart';
import 'package:dorm_app/src/pages/home_page.dart';
import 'package:dorm_app/src/pages/my_apartment.dart';
import 'package:get/get.dart';

class AppRoute {
  static const String initial = '/';
  static const String community = '/community';
  static const String invoice = '/invoice';
  static const String myApartment = '/my_apartment';

  static String getInitial() => '$initial';
  static String getCommunity() => '$community';
  static String getInvoice() => '$invoice';
  static String getMyApartment() => '$myApartment';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: community, page: () => Community()),
    GetPage(name: invoice, page: () => Invoice()),
    GetPage(name: myApartment, page: () => MyApartment()),
  ];
}
