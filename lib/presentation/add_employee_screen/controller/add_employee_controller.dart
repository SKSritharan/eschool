import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/add_employee_screen/models/add_employee_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddEmployeeController extends GetxController {
  TextEditingController employeeNameController = TextEditingController();

  TextEditingController employeeEmailController = TextEditingController();

  TextEditingController employeeDobController = TextEditingController();

  TextEditingController employeePhoneController = TextEditingController();

  Rx<AddEmployeeModel> addEmployeeModelObj = AddEmployeeModel().obs;

  String? imageUrl;


  void uploadEmployeeImage(File image) {
    uploadImageToStorage(image);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadImageToStorage(File imageFile) async {
    try {
      String fileName = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      Reference reference = _storage.ref().child('profile/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      imageUrl = downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }


    @override
    void onReady() {
      super.onReady();
    }
  }

  Future<void> createEmployeeAccount() async {
    try {
      // Create the user account using Firebase Authentication
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: employeeEmailController.text,
        password: employeePhoneController.text,
      );

      // Store the user profile information in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': employeeNameController.text,
        'email': employeeEmailController.text,
        'phoneNo': employeePhoneController.text,
        'dob': employeeDobController.text,
        'role': 'employee',
        'image': imageUrl
      });
    } catch (e) {
      // Handle any errors that occur
      print('Error creating teacher account: $e');
    }
  }


  @override
  void onClose() {
    super.onClose();
    employeeNameController.dispose();
    employeeEmailController.dispose();
    employeeDobController.dispose();
    employeePhoneController.dispose();
  }

}
