import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_teachers_list_page/models/admin_teachers_list_model.dart';

import '../../../data/models/teacher.dart';

class AdminTeachersListController extends GetxController {
  // AdminTeachersListController(this.adminTeachersListModelObj);
  // Rx<AdminTeachersListModel> adminTeachersListModelObj;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Teacher> teachersList = <Teacher>[].obs;

  @override
  void onReady() {
    super.onReady();
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

  @override
  void onClose() {
    super.onClose();
  }
}
