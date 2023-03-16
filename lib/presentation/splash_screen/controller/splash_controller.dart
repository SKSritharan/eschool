import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/splash_screen/models/splash_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _isSignedIn = false.obs;
  Rx<SplashModel> splashModelObj = SplashModel().obs;

  @override
  void onReady() {
    super.onReady();
    // Wait until the authentication process finishes
    User? user = _auth.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Get.offAllNamed(AppRoutes.roleScreen);
        print('User is currently signed out!');
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final user_role = prefs.getString('user_role').toString();
        print(user_role);
        if (user_role == 'admin') {
          Get.toNamed(AppRoutes.adminStudentsListTabContainerScreen);
        } else if (user_role == 'teacher') {
          Get.toNamed(AppRoutes.teacherDasboardScreen);
        } else if (user_role == 'student') {
          Get.toNamed(AppRoutes.studentDashboardScreen);
        } else if (user_role == 'employee') {
          Get.toNamed(AppRoutes.employeeTabContainerScreen);
        }
        // else {
        //   await _auth.signOut();
        //   Get.offAllNamed(AppRoutes.roleScreen);
        // }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
