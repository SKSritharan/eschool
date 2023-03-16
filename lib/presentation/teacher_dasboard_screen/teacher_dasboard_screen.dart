import '../teacher_dasboard_screen/widgets/listrectangleone2_item_widget.dart';
import 'controller/teacher_dasboard_controller.dart';
import 'models/listrectangleone2_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';

class TeacherDasboardScreen extends GetWidget<TeacherDasboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 40,
                leading: AppbarImage(
                    height: getSize(24),
                    width: getSize(24),
                    svgPath: ImageConstant.imgVolume,
                    margin: getMargin(left: 16, top: 53, bottom: 21),
                    onTap: onTapVolume2),
                centerTitle: true,
                title: AppbarTitle(
                    text: "lbl_students".tr,
                    margin: getMargin(top: 51, bottom: 22)),
                actions: [
                  Container(
                      height: getSize(25),
                      width: getSize(25),
                      margin:
                          getMargin(left: 26, top: 52, right: 26, bottom: 21),
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
                            onTap: onTapUser1)
                      ]))
                ],
                styleType: Style.bgFillBluegray700),
            body: Padding(
                padding: getPadding(left: 13, top: 19, right: 23, bottom: 174),
                child: Obx(() => ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: getVerticalSize(13));
                    },
                    itemCount: controller.teacherDasboardModelObj.value
                        .listrectangleone2ItemList.length,
                    itemBuilder: (context, index) {
                      Listrectangleone2ItemModel model = controller
                          .teacherDasboardModelObj
                          .value
                          .listrectangleone2ItemList[index];
                      return Listrectangleone2ItemWidget(model);
                    }))),
            floatingActionButton: CustomFloatingButton(
                height: 44,
                width: 44,
                onTap: () {
                  onTapBtnFloatingactionbutton();
                },
                child: CustomImageView(
                    svgPath: ImageConstant.imgPlus,
                    height: getVerticalSize(22.0),
                    width: getHorizontalSize(22.0)))));
  }

  onTapBtnFloatingactionbutton() {
    Get.toNamed(AppRoutes.addStudentScreen);
  }

  onTapVolume2() {
    Get.toNamed(AppRoutes.announcementsListScreen);
  }

  onTapUser1() {
    Get.toNamed(AppRoutes.myProfileScreen);
  }
}
