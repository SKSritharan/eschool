import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/teacher_dasboard_screen/models/teacher_dasboard_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../data/models/student.dart';

class TeacherDasboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Student> studentsList = <Student>[].obs;

  TextEditingController editStudentNameController = TextEditingController();
  TextEditingController editStudentEmailController = TextEditingController();
  TextEditingController editStudentClzController = TextEditingController();
  TextEditingController editStudentPhoneController = TextEditingController();


  @override
  void onReady() {
    super.onReady();
  }

  //update Student data
  Future<void> updateStudentData(String id) async {
    final userId = id;
    try {
      final userRef =
      FirebaseFirestore.instance.collection('users').doc(userId);

      await userRef.update({
        'name': editStudentNameController.text,
        'phoneNo': editStudentPhoneController.text,
        'class': editStudentClzController.text,
      });

      Get.snackbar('Success', 'Student Updated successfully');

    } catch (error) {
      Get.snackbar('Error', 'Failed to update Student');
      print(error);
    }
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
                  clz: doc.data()['class'] ?? '',
                  dob: doc.data()['dob'] ?? '',
                  phoneNo: doc.data()['phoneNo'] ?? '',
                ))
            .toList());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
