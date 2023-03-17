import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/employee_dashboard_students_list_screen/models/employee_dashboard_students_list_model.dart';
import 'package:flutter/material.dart';

import '../../../data/models/student.dart';

class EmployeeDashboardStudentsListController extends GetxController {
  TextEditingController scheduletabController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Student> studentsList = <Student>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  Stream<List<Student>> get studentsStream {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'student')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Student(
                  id: doc.id,
                  name: doc.data()['name'] ?? '',
                  email: doc.data()['email'] ?? '',
                  image: doc.data()['image'] ?? '',
                  clz: doc.data()['subject'] ?? '',
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
