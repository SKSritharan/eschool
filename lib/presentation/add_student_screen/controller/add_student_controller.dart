import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/add_student_screen/models/add_student_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddStudentController extends GetxController {
  TextEditingController studentNameController = TextEditingController();

  TextEditingController studentEmailController = TextEditingController();

  TextEditingController studentPhoneController = TextEditingController();

  TextEditingController studentDobController = TextEditingController();

  TextEditingController studentClassController = TextEditingController();

  Rx<AddStudentModel> addStudentModelObj = AddStudentModel().obs;

  String? imageUrl;

  @override
  void onReady() {
    super.onReady();
  }

  void uploadStudentImage(File image) {
    uploadImageToStorage(image);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<void> createStudentAccount() async {
    try {
      // Create the user account using Firebase Authentication
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: studentEmailController.text,
        password: studentPhoneController.text,
      );

      // Store the user profile information in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': studentNameController.text,
        'email': studentEmailController.text,
        'phoneNo': studentPhoneController.text,
        'dob': studentDobController.text,
        'role': 'student',
        'class': studentClassController.text,
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
    studentNameController.dispose();
    studentEmailController.dispose();
    studentPhoneController.dispose();
    studentDobController.dispose();
    studentClassController.dispose();
  }
}
