import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/announcements_list_screen/models/announcements_list_model.dart';

class AnnouncementsListController extends GetxController {
  Rx<AnnouncementsListModel> announcementsListModelObj =
      AnnouncementsListModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
