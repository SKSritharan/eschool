import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_employee_list_page/models/admin_employee_list_model.dart';

import '../../../data/models/employee.dart';

class AdminEmployeeListController extends GetxController {
  // AdminEmployeeListController(this.adminEmployeeListModelObj);
  //
  // Rx<AdminEmployeeListModel> adminEmployeeListModelObj;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Employee> employeeList = <Employee>[].obs;

  @override
  void onReady() {
    super.onReady();
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

  @override
  void onClose() {
    super.onClose();
  }
}
