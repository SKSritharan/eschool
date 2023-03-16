import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/announcements_screen/models/announcements_model.dart';
import 'package:flutter/material.dart';

class AnnouncementsController extends GetxController {
  TextEditingController groupThirteenController = TextEditingController();

  TextEditingController groupFourteenController = TextEditingController();

  Rx<AnnouncementsModel> announcementsModelObj = AnnouncementsModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupThirteenController.dispose();
    groupFourteenController.dispose();
  }
}
