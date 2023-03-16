import '../employee_dashboard_teachers_list_screen/widgets/listrectangleone_item_widget.dart';
import 'controller/employee_dashboard_teachers_list_controller.dart';
import 'models/listrectangleone_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_button.dart';
import 'package:eschool/widgets/custom_floating_button.dart';
import 'package:eschool/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EmployeeDashboardTeachersListScreen
    extends GetWidget<EmployeeDashboardTeachersListController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 43,
                leading: AppbarImage(
                    height: getSize(24),
                    width: getSize(24),
                    svgPath: ImageConstant.imgVolume,
                    margin: getMargin(left: 19, top: 53, bottom: 21),
                    onTap: onTapVolume),
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
                            onTap: onTapUser)
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
                      Padding(
                          padding: getPadding(top: 9),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  height: getVerticalSize(37),
                                  width: getHorizontalSize(121),
                                  text: "lbl_teacher".tr,
                                  variant: ButtonVariant.OutlineBlack90019_1,
                                  shape: ButtonShape.RoundedBorder5,
                                  fontStyle: ButtonFontStyle
                                      .RalewaySemiBold14WhiteA700,
                                ),
                                CustomButton(
                                    height: getVerticalSize(37),
                                    width: getHorizontalSize(121),
                                    text: "lbl_student".tr,
                                    variant: ButtonVariant.OutlineBlack90019,
                                    shape: ButtonShape.RoundedBorder5,
                                    fontStyle:
                                        ButtonFontStyle.RalewaySemiBold14,
                                    onTap: onTapStudent)
                              ])),
                      Padding(
                          padding: getPadding(
                              left: 19, top: 22, right: 17, bottom: 125),
                          child: Obx(() => ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: getVerticalSize(10));
                              },
                              itemCount: controller
                                  .employeeDashboardTeachersListModelObj
                                  .value
                                  .listrectangleoneItemList
                                  .length,
                              itemBuilder: (context, index) {
                                ListrectangleoneItemModel model = controller
                                    .employeeDashboardTeachersListModelObj
                                    .value
                                    .listrectangleoneItemList[index];
                                return ListrectangleoneItemWidget(model);
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
    Get.toNamed(AppRoutes.addTeacherScreen);
  }

  onTapStudent() {
    Get.toNamed(AppRoutes.employeeDashboardStudentsListScreen);
  }

  onTapVolume() {
    Get.toNamed(AppRoutes.announcementsListScreen);
  }

  onTapUser() {
    Get.toNamed(AppRoutes.myProfileScreen);
  }
}
