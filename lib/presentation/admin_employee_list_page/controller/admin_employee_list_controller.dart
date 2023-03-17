import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_employee_list_page/models/admin_employee_list_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../data/models/employee.dart';

class AdminEmployeeListController extends GetxController {

  TextEditingController editEmployeeNameController = TextEditingController();
  TextEditingController editEmployeeEmailController = TextEditingController();
  TextEditingController editEmployeePhoneController = TextEditingController();

  String? imageUrl;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Employee> employeeList = <Employee>[].obs;

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

  Stream<List<Employee>> get employeeStream {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'employee')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Employee(
                  id: doc.id,
                  name: doc.data()['name'] ?? '',
                  email: doc.data()['email'] ?? '',
                  image: doc.data()['image'] ?? '',
                  dob: doc.data()['dob'] ?? '',
                  phoneNo: doc.data()['phoneNo'] ?? '',
                ))
            .toList());
  }

  void deleteEmployee(String employeeId) async {
    try {
      // Delete user from Firebase Authentication

      // Delete user from users collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(employeeId)
          .delete();

      // Remove user from local list
      employeeList.removeWhere((employee) => employee.id == employeeId);

      // Show success message
      Get.snackbar('Success', 'Employee deleted successfully');
    } catch (e) {
      // Show error message
      Get.snackbar('Error', 'Failed to delete employee');
      print('Error deleting employee: $e');
    }
  }


  //update Employee data
  Future<void> updateEmployeeData(String id) async {
    final userId = id;
    try {
      final userRef =
      FirebaseFirestore.instance.collection('users').doc(userId);

      await userRef.update({
        'name': editEmployeeNameController.text,
        'phoneNo': editEmployeePhoneController.text,
        'image': imageUrl
      });

      Get.snackbar('Success', 'Employee Updated successfully');

    } catch (error) {
      Get.snackbar('Error', 'Failed to update Employee');
      print(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
