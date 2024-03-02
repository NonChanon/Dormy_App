import 'package:dorm_app/src/pages/user/Invoice.dart';
import 'package:dorm_app/src/pages/community.dart';
import 'package:dorm_app/src/pages/home_page.dart';
import 'package:dorm_app/src/pages/sign_in.dart';
import 'package:dorm_app/src/pages/admin/management.dart';
import 'package:dorm_app/src/pages/my_apartment.dart';
import 'package:dorm_app/src/pages/sign_up.dart';
import 'package:get/get.dart';

class AppRoute {
  static const String initial = '/';
  static const String community = '/community';
  static const String invoice = '/invoice';
  static const String myApartment = '/my_apartment';
  static const String management = '/management';
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';

  static String getInitial() => '$initial';
  static String getCommunity() => '$community';
  static String getInvoice() => '$invoice';
  static String getMyApartment() => '$myApartment';
  static String getManagement() => '$management';
  static String getSignIn() => '$signIn';
  static String getSignUp() => '$signUp';
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: community, page: () => Community()),
    GetPage(name: invoice, page: () => Invoice()),
    GetPage(name: myApartment, page: () => MyApartment()),
    GetPage(name: management, page: () => Management()),
    GetPage(name: signIn, page: () => SignIn()),
    GetPage(name: signUp, page: () => SignUp())
  ];
}
