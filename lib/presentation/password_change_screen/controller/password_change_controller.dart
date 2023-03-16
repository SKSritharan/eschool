import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/password_change_screen/models/password_change_model.dart';
import 'package:flutter/material.dart';

class PasswordChangeController extends GetxController {
  TextEditingController groupFiveController = TextEditingController();

  TextEditingController groupSixController = TextEditingController();

  TextEditingController groupSevenController = TextEditingController();

  Rx<PasswordChangeModel> passwordChangeModelObj = PasswordChangeModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupFiveController.dispose();
    groupSixController.dispose();
    groupSevenController.dispose();
  }
}
