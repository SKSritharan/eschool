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
  String? imageUrl;

  @override
  void onReady() {
    super.onReady();
  }


  void uploadImage(File img) {
    uploadImageToStorage(img);
  }
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<void> uploadImageToStorage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = _storage.ref().child('profile/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      imageUrl = downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }
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
        'image': imageUrl
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
