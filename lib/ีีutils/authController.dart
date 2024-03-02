import 'package:get/get.dart';

enum UserRole {
  admin,
  user,
}

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var currentUserRole = UserRole.user.obs;

  void login() {
    isLoggedIn.value = true;
  }

  bool checkIfUserHaveDormitory() {
    // ใส่โค้ดที่ตรวจสอบว่าผู้ใช้มีหอพักหรือไม่
    return true; // สมมติว่ายังไม่มีหอพัก
  }

  UserRole getCurrentUserRole() {
    // ใส่โค้ดที่นี่เพื่อดึงข้อมูลสิทธิ์ของผู้ใช้งาน
    // เช่น การตรวจสอบในฐานข้อมูลหรือบนเซิร์ฟเวอร์
    return UserRole.admin; // ตัวอย่างเท่านี้คือการสมมติเท่านั้น
  }
}
