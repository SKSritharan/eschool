import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/add_teacher_screen/models/add_teacher_model.dart';

class AddTeacherController extends GetxController {
  TextEditingController teacherNameController = TextEditingController();
  TextEditingController teacherEmailController = TextEditingController();
  TextEditingController teacherPhoneController = TextEditingController();
  TextEditingController teacherDobController = TextEditingController();
  TextEditingController teacherSubjectController = TextEditingController();
  Rx<AddTeacherModel> addTeacherModelObj = AddTeacherModel().obs;
  String? imageUrl;

  @override
  void onReady() {
    super.onReady();
  }

  void uploadTeacherImage(File image) {
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

  Future<void> createTeacherAccount() async {
    try {
      // Create the user account using Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: teacherEmailController.text,
        password: teacherPhoneController.text,
      );

      // Store the user profile information in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': teacherNameController.text,
        'email': teacherEmailController.text.trim(),
        'phoneNo': teacherPhoneController.text,
        'dob': teacherDobController.text,
        'role': 'teacher',
        'subject': teacherSubjectController.text,
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
    teacherEmailController.dispose();
    teacherNameController.dispose();
    teacherPhoneController.dispose();
    teacherDobController.dispose();
    teacherSubjectController.dispose();
  }
}
