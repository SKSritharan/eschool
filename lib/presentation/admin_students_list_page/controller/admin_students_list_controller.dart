import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_students_list_page/models/admin_students_list_model.dart';

import '../../../data/models/student.dart';

class AdminStudentsListController extends GetxController {
  // AdminStudentsListController(this.adminStudentsListModelObj);
  //
  // Rx<AdminStudentsListModel> adminStudentsListModelObj;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Student> studentsList = <Student>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  Stream<List<Student>> get studentsStream {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'student')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Student(
                  id: doc.id,
                  name: doc.data()['name'] ?? '',
                  email: doc.data()['email'] ?? '',
                  image: doc.data()['image'] ?? '',
                  clz: doc.data()['subject'] ?? '',
                  dob: doc.data()['dob'] ?? '',
                  phoneNo: doc.data()['phoneNo'] ?? '',
                ))
            .toList());
  }

  void deleteStudent(String studentId) async {
    try {
      // Delete user from Firebase Authentication

      // Delete user from users collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(studentId)
          .delete();

      // Remove user from local list
      studentsList.removeWhere((student) => student.id == studentId);

      // Show success message
      Get.snackbar('Success', 'Student deleted successfully');
    } catch (e) {
      // Show error message
      Get.snackbar('Error', 'Failed to delete Student');
      print('Error deleting student: $e');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
