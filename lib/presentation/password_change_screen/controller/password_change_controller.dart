import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/password_change_screen/models/password_change_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordChangeController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  Rx<PasswordChangeModel> passwordChangeModelObj = PasswordChangeModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> changePassword() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;

    // Get credentials for reauthentication
    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPasswordController.text,
    );

    try {
      // Reauthenticate user with current password
      await user.reauthenticateWithCredential(credential);

      // Change password
      await user.updatePassword(newPasswordController.text);

      Get.snackbar('Success', 'Password Updated successfully');

      print('Password updated successfully!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password. Try again.');
        print('Wrong password: ${e.message}');
      } else {
        Get.snackbar('Error', 'Oh oh!. Something went wrong');
        print('Failed to update password: ${e.message}');
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }
}
