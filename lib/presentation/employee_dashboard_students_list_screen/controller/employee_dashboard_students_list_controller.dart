import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/employee_dashboard_students_list_screen/models/employee_dashboard_students_list_model.dart';
import 'package:flutter/material.dart';

class EmployeeDashboardStudentsListController extends GetxController {
  TextEditingController scheduletabController = TextEditingController();

  Rx<EmployeeDashboardStudentsListModel> employeeDashboardStudentsListModelObj =
      EmployeeDashboardStudentsListModel().obs;

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
