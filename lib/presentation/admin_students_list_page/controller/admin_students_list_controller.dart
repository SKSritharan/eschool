import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_students_list_page/models/admin_students_list_model.dart';

class AdminStudentsListController extends GetxController {
  AdminStudentsListController(this.adminStudentsListModelObj);

  Rx<AdminStudentsListModel> adminStudentsListModelObj;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
