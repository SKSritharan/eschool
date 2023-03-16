import '../employee_dashboard_students_list_screen/widgets/listrectangleone1_item_widget.dart';
import 'controller/employee_dashboard_students_list_controller.dart';
import 'models/listrectangleone1_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_button.dart';
import 'package:eschool/widgets/custom_floating_button.dart';
import 'package:eschool/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EmployeeDashboardStudentsListScreen
    extends GetWidget<EmployeeDashboardStudentsListController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 42,
                leading: AppbarImage(
                    height: getSize(24),
                    width: getSize(24),
                    svgPath: ImageConstant.imgVolume,
                    margin: getMargin(left: 18, top: 53, bottom: 21),
                    onTap: onTapVolume1),
                centerTitle: true,
                title: AppbarTitle(
                    text: "lbl_students".tr,
                    margin: getMargin(top: 51, bottom: 22)),
                actions: [
                  Container(
                      height: getSize(25),
                      width: getSize(25),
                      margin:
                          getMargin(left: 24, top: 52, right: 24, bottom: 21),
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
                            svgPath: ImageConstant.imgUser)
                      ]))
                ],
                styleType: Style.bgFillBluegray700),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(top: 1, bottom: 1),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: getPadding(top: 7, right: 55),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  CustomButton(
                                  height: getVerticalSize(37),
                            width: getHorizontalSize(121),
                            text: "lbl_teacher".tr,
                            variant: ButtonVariant.OutlineBlack90019,
                            shape: ButtonShape.RoundedBorder5,
                            fontStyle:
                            ButtonFontStyle.RalewaySemiBold14,
                                    onTap: onTabTeacher,
                          ),
                                    CustomButton(
                                        height: getVerticalSize(37),
                                        width: getHorizontalSize(121),
                                        text: "lbl_student".tr,
                                        variant:
                                            ButtonVariant.OutlineBlack90019_1,
                                        shape: ButtonShape.RoundedBorder5,
                                        fontStyle: ButtonFontStyle
                                            .RalewaySemiBold14WhiteA700)
                                  ]))),
                      Padding(
                          padding: getPadding(
                              left: 22, top: 21, right: 14, bottom: 128),
                          child: Obx(() => ListView.separated(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: getVerticalSize(10));
                              },
                              itemCount: controller
                                  .employeeDashboardStudentsListModelObj
                                  .value
                                  .listrectangleone1ItemList
                                  .length,
                              itemBuilder: (context, index) {
                                Listrectangleone1ItemModel model = controller
                                    .employeeDashboardStudentsListModelObj
                                    .value
                                    .listrectangleone1ItemList[index];
                                return Listrectangleone1ItemWidget(model);
                              })))
                    ])),
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
  onTabTeacher() {
    Get.toNamed(AppRoutes.employeeDashboardTeachersListScreen);
  }
  onTapVolume1() {
    Get.toNamed(AppRoutes.announcementsListScreen);
  }
}
