import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/my_profile_screen/models/my_profile_model.dart';

class MyProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  Rx<MyProfileModel> myProfileModelObj = MyProfileModel().obs;

  RxString name = "".obs;
  RxString email = "".obs;
  RxString phoneNo = "".obs;
  RxString dob = "".obs;
  RxString profilePictureUrl = "".obs;
  RxString role = "".obs;

  String? imageUrl;

  void uploadImage(File image) {
    uploadImageToStorage(image);
  }

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString("user_name") ?? "";
    phoneNo.value = prefs.getString("user_phoneNo") ?? "";
    dob.value = prefs.getString("user_dob") ?? "";
    email.value = prefs.getString("user_email") ?? "";
    profilePictureUrl.value = prefs.getString("user_image") ?? "";
    role.value = prefs.getString("user_role") ?? "";

    nameController = TextEditingController(text: name.value);
    emailController = TextEditingController(text: email.value);
    phoneNoController = TextEditingController(text: phoneNo.value);
    dobController = TextEditingController(text: dob.value);
    imageUrl = profilePictureUrl.value;
  }

  //upload image
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

  //update user data
  Future<void> updateUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      await userRef.update({
        'name': nameController.text,
        'phoneNo': phoneNoController.text,
        'dob': dobController.text,
        'image': imageUrl
      });
      Get.snackbar('Success', 'Prodile Updated successfully');
    } catch (error) {
      Get.snackbar('Error', 'Failed to update profile');
      print(error);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    dobController.dispose();
  }
}
