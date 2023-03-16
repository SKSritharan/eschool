import '../student_dashboard_screen/widgets/listrectangleone3_item_widget.dart';
import 'controller/student_dashboard_controller.dart';
import 'models/listrectangleone3_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class StudentDashboardScreen extends GetWidget<StudentDashboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 43,
                leading: AppbarImage(
                    height: getSize(24),
                    width: getSize(24),
                    svgPath: ImageConstant.imgVolume,
                    margin: getMargin(left: 19, top: 53, bottom: 21),
                    onTap: onTapVolume3),
                centerTitle: true,
                title: AppbarTitle(
                    text: "lbl_teachers".tr,
                    margin: getMargin(top: 51, bottom: 22)),
                actions: [
                  Container(
                      height: getSize(25),
                      width: getSize(25),
                      margin:
                          getMargin(left: 23, top: 52, right: 23, bottom: 21),
                      child: Stack(alignment: Alignment.center, children: [
                        AppbarImage(
                            height: getSize(9),
                            width: getSize(9),
                            svgPath: ImageConstant.imgSettings,
                            margin: getMargin(
                                left: 7, top: 4, right: 8, bottom: 11)),
                        AppbarImage(
                            height: getSize(25),
                            width: getSize(25),
                            svgPath: ImageConstant.imgUser,
                            onTap: onTapUser2)
                      ]))
                ],
                styleType: Style.bgFillBluegray700),
            body: Padding(
                padding: getPadding(left: 21, top: 19, right: 15),
                child: Obx(() => ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: getVerticalSize(13));
                    },
                    itemCount: controller.studentDashboardModelObj.value
                        .listrectangleone3ItemList.length,
                    itemBuilder: (context, index) {
                      Listrectangleone3ItemModel model = controller
                          .studentDashboardModelObj
                          .value
                          .listrectangleone3ItemList[index];
                      return Listrectangleone3ItemWidget(model);
                    })))));
  }

  onTapVolume3() {
    Get.toNamed(AppRoutes.announcementsListScreen);
  }

  onTapUser2() {
    Get.toNamed(AppRoutes.myProfileScreen);
  }
}
