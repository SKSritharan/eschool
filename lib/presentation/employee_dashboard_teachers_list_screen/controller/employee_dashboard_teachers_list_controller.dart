import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/employee_dashboard_teachers_list_screen/models/employee_dashboard_teachers_list_model.dart';
import 'package:flutter/material.dart';

import '../../../data/models/teacher.dart';

class EmployeeDashboardTeachersListController extends GetxController {
  TextEditingController scheduletabController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Teacher> teachersList = <Teacher>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  Stream<List<Teacher>> get teachersStream {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'teacher')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Teacher(
                  id: doc.id,
                  name: doc.data()['name'] ?? '',
                  email: doc.data()['email'] ?? '',
                  image: doc.data()['image'] ?? '',
                  subject: doc.data()['subject'] ?? '',
                  dob: doc.data()['dob'] ?? '',
                  phoneNo: doc.data()['phoneNo'] ?? '',
                ))
            .toList());
  }

  @override
  void onClose() {
    super.onClose();
    scheduletabController.dispose();
  }
}
