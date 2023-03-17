import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_teachers_list_page/models/admin_teachers_list_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../data/models/teacher.dart';

class AdminTeachersListController extends GetxController {
  // AdminTeachersListController(this.adminTeachersListModelObj);
  // Rx<AdminTeachersListModel> adminTeachersListModelObj;

  TextEditingController editTeacherNameController = TextEditingController();
  TextEditingController editTeacherEmailController = TextEditingController();
  TextEditingController editTeacherSubjectController = TextEditingController();
  TextEditingController editTeacherPhoneController = TextEditingController();
  String? imageUrl;



  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Teacher> teachersList = <Teacher>[].obs;







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

  void deleteTeacher(String teacherId) async {
    try {
      // Delete user from Firebase Authentication

      // Delete user from users collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(teacherId)
          .delete();

      // Remove teacher from local list
      teachersList.removeWhere((teacher) => teacher.id == teacherId);

      // Show success message
      Get.snackbar('Success', 'Teacher deleted successfully');
    } catch (e) {
      // Show error message
      Get.snackbar('Error', 'Failed to delete teacher');
      print('Error deleting teacher: $e');
    }
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
  }
}
