import '../admin_students_list_page/widgets/listrectangleone5_item_widget.dart';
import 'controller/admin_students_list_controller.dart';
import 'models/admin_students_list_model.dart';
import 'models/listrectangleone5_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AdminStudentsListPage extends StatelessWidget {
  AdminStudentsListController controller =
      Get.put(AdminStudentsListController(AdminStudentsListModel().obs));

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
                  left: 17,
                  top: 30,
                  right: 19,
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
                    itemCount: controller.adminStudentsListModelObj.value
                        .listrectangleone5ItemList.length,
                    itemBuilder: (context, index) {
                      Listrectangleone5ItemModel model = controller
                          .adminStudentsListModelObj
                          .value
                          .listrectangleone5ItemList[index];
                      return Listrectangleone5ItemWidget(
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
