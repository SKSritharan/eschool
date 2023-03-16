import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eschool/presentation/sign_in_screen/models/sign_in_model.dart';

class SignInController extends GetxController {
  TextEditingController emailvalueController = TextEditingController();
  TextEditingController passwordvalueController = TextEditingController();

  Rx<SignInModel> signInModelObj = SignInModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  void signInUsingEmailPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailvalueController.text,
        password: passwordvalueController.text,
      );

      if (userCredential.user != null) {
        // Store the user profile data in shared preferences
        await storeUserProfileData(userCredential.user!.uid);

        // Fetch the user role from Firestore
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user!.uid)
                .get();
        final String userRole = snapshot.data()!['role'];

        // Navigate to the proper screen based on the user role
        if (userRole == 'admin') {
          Get.toNamed(AppRoutes.adminStudentsListTabContainerScreen);
        } else if (userRole == 'teacher') {
          Get.toNamed(AppRoutes.teacherDasboardScreen);
        } else if (userRole == 'student') {
          Get.toNamed(AppRoutes.studentDashboardScreen);
        } else if (userRole == 'employee') {
          Get.toNamed(AppRoutes.employeeDashboardTeachersListScreen);
        }else {
          print('Unknown user role');
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (error.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
  }

  Future<void> storeUserProfileData(String userId) async {
    try {
      // Fetch user profile data from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .get();

      // Store the user profile data in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_name', userDoc.data()!['name']);
      prefs.setString('user_email', userDoc.data()!['email']);
      prefs.setString('user_role', userDoc.data()!['role']);
      prefs.setString('user_phoneNo', userDoc.data()!['phoneNo']);
      prefs.setString('user_dob', userDoc.data()!['dob']);
      prefs.setString('user_image', userDoc.data()!['image']);
    } catch (e) {
      print('Error fetching user profile data: $e');
    }
  }

  @override
  void dispose() {
    emailvalueController.dispose();
    passwordvalueController.dispose();
    super.dispose();
  }
}
