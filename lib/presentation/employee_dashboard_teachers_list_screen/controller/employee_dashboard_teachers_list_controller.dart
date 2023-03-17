import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../data/models/teacher.dart';

class EmployeeDashboardTeachersListController extends GetxController {
  TextEditingController scheduletabController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Teacher> teachersList = <Teacher>[].obs;

  TextEditingController editTeacherNameController = TextEditingController();
  TextEditingController editTeacherEmailController = TextEditingController();
  TextEditingController editTeacherSubjectController = TextEditingController();
  TextEditingController editTeacherPhoneController = TextEditingController();

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

  //update Teacher data
  Future<void> updateTeacherData(String id) async {
    final userId = id;
    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      await userRef.update({
        'name': editTeacherNameController.text,
        'phoneNo': editTeacherPhoneController.text,
        'subject': editTeacherSubjectController.text,
      });

      Get.snackbar('Success', 'Teacher Updated successfully');
    } catch (error) {
      Get.snackbar('Error', 'Failed to update Teacher');
      print(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
    scheduletabController.dispose();
  }
}
