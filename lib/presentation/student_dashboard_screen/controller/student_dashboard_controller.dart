import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/student_dashboard_screen/models/student_dashboard_model.dart';

class StudentDashboardController extends GetxController {
  Rx<StudentDashboardModel> studentDashboardModelObj =
      StudentDashboardModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
