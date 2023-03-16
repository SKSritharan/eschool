import '../admin_employee_list_page/widgets/listrectangleone6_item_widget.dart';
import 'controller/admin_employee_list_controller.dart';
import 'models/admin_employee_list_model.dart';
import 'models/listrectangleone6_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AdminEmployeeListPage extends StatelessWidget {
  AdminEmployeeListController controller =
      Get.put(AdminEmployeeListController(AdminEmployeeListModel().obs));

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
                  top: 24,
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
                    itemCount: controller.adminEmployeeListModelObj.value
                        .listrectangleone6ItemList.length,
                    itemBuilder: (context, index) {
                      Listrectangleone6ItemModel model = controller
                          .adminEmployeeListModelObj
                          .value
                          .listrectangleone6ItemList[index];
                      return Listrectangleone6ItemWidget(
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
