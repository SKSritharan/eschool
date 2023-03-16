import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/add_student_screen/models/add_student_model.dart';
import 'package:flutter/material.dart';

class AddStudentController extends GetxController {
  TextEditingController groupTwelveController = TextEditingController();

  TextEditingController groupElevenController = TextEditingController();

  TextEditingController groupTenController = TextEditingController();

  TextEditingController groupEightController = TextEditingController();

  TextEditingController languageController = TextEditingController();

  Rx<AddStudentModel> addStudentModelObj = AddStudentModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupTwelveController.dispose();
    groupElevenController.dispose();
    groupTenController.dispose();
    groupEightController.dispose();
    languageController.dispose();
  }
}
