import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/add_employee_screen/models/add_employee_model.dart';
import 'package:flutter/material.dart';

class AddEmployeeController extends GetxController {
  TextEditingController groupTwentyThreeController = TextEditingController();

  TextEditingController groupTwentyTwoController = TextEditingController();

  TextEditingController groupTwentyOneController = TextEditingController();

  TextEditingController groupTwentyController = TextEditingController();

  Rx<AddEmployeeModel> addEmployeeModelObj = AddEmployeeModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupTwentyThreeController.dispose();
    groupTwentyTwoController.dispose();
    groupTwentyOneController.dispose();
    groupTwentyController.dispose();
  }
}
