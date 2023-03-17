import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/announcements_screen/models/announcements_model.dart';
import 'package:flutter/material.dart';

class AnnouncementsController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Rx<AnnouncementsModel> announcementsModelObj = AnnouncementsModel().obs;

  Future<void> createAnnouncement() async {
    try {
      await FirebaseFirestore.instance.collection('announcements').doc().set({
        'title': titleController.text,
        'message': messageController.text,
      });
    } catch (e) {
      // Handle any errors that occur
      print('Error creating announcements: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    messageController.dispose();
  }
}
