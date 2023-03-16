import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/employee_dashboard_teachers_list_screen/models/employee_dashboard_teachers_list_model.dart';
import 'package:flutter/material.dart';

class EmployeeDashboardTeachersListController extends GetxController {
  TextEditingController scheduletabController = TextEditingController();

  Rx<EmployeeDashboardTeachersListModel> employeeDashboardTeachersListModelObj =
      EmployeeDashboardTeachersListModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    scheduletabController.dispose();
  }
}
