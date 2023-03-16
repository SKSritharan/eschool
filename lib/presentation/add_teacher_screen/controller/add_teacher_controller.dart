import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/add_teacher_screen/models/add_teacher_model.dart';
import 'package:flutter/material.dart';

class AddTeacherController extends GetxController {
  TextEditingController groupNineteenController = TextEditingController();

  TextEditingController groupEighteenController = TextEditingController();

  TextEditingController groupSeventeenController = TextEditingController();

  TextEditingController groupFifteenController = TextEditingController();

  TextEditingController languageController = TextEditingController();

  Rx<AddTeacherModel> addTeacherModelObj = AddTeacherModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupNineteenController.dispose();
    groupEighteenController.dispose();
    groupSeventeenController.dispose();
    groupFifteenController.dispose();
    languageController.dispose();
  }
}
