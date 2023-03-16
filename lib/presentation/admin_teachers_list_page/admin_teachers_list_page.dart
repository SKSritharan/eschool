import '../admin_teachers_list_page/widgets/listrectangleone4_item_widget.dart';
import 'controller/admin_teachers_list_controller.dart';
import 'models/admin_teachers_list_model.dart';
import 'models/listrectangleone4_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AdminTeachersListPage extends StatelessWidget {
  AdminTeachersListController controller =
      Get.put(AdminTeachersListController(AdminTeachersListModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                  left: 18,
                  top: 31,
                  right: 18,
                ),
                child: Obx(
                  () => ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: getVerticalSize(
                          13,
                        ),
                      );
                    },
                    itemCount: controller.adminTeachersListModelObj.value
                        .listrectangleone4ItemList.length,
                    itemBuilder: (context, index) {
                      Listrectangleone4ItemModel model = controller
                          .adminTeachersListModelObj
                          .value
                          .listrectangleone4ItemList[index];
                      return Listrectangleone4ItemWidget(
                        model,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
