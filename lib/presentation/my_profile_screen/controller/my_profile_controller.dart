import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/my_profile_screen/models/my_profile_model.dart';

class MyProfileController extends GetxController {
  TextEditingController groupFourController = TextEditingController();
  TextEditingController groupThreeController = TextEditingController();
  TextEditingController groupTwoController = TextEditingController();
  TextEditingController groupOneController = TextEditingController();
  Rx<MyProfileModel> myProfileModelObj = MyProfileModel().obs;

  RxString name = "".obs;
  RxString email = "".obs;
  RxString phoneNo = "".obs;
  RxString dob = "".obs;
  RxString profilePictureUrl = "".obs;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString("user_name") ?? "";
    phoneNo.value = prefs.getString("user_phoneNo") ?? "";
    dob.value = prefs.getString("user_dob") ?? "";
    email.value = prefs.getString("user_email") ?? "";
    profilePictureUrl.value = prefs.getString("user_image") ?? "";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupFourController.dispose();
    groupThreeController.dispose();
    groupTwoController.dispose();
    groupOneController.dispose();
  }
}
