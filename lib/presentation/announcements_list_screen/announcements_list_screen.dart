import 'controller/announcements_list_controller.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AnnouncementsListScreen extends GetWidget<AnnouncementsListController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 50,
                leading: AppbarImage(
                    height: getVerticalSize(17),
                    width: getHorizontalSize(30),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 20, top: 54, bottom: 27),
                    onTap: onTapArrowleft),
                centerTitle: true,
                title: AppbarTitle(
                    text: "lbl_announcements".tr,
                    margin: getMargin(top: 54, bottom: 20)),
                styleType: Style.bgFillBluegray700),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 22, top: 33, right: 22, bottom: 33),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: double.maxFinite,
                          child: Container(
                              width: getHorizontalSize(370),
                              padding: getPadding(
                                  left: 20, top: 9, right: 20, bottom: 9),
                              decoration: AppDecoration.outlineBlack9003f
                                  .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder20),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("lbl_title".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtRobotoRomanBold20
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.15))),
                                    Padding(
                                        padding: getPadding(
                                            left: 8,
                                            top: 2,
                                            right: 27,
                                            bottom: 17),
                                        child: Text("msg_lorem_ipsum_dolor".tr,
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtRobotoRegular16
                                                .copyWith(
                                                    letterSpacing:
                                                        getHorizontalSize(
                                                            0.15))))
                                  ]))),
                      Container(
                          width: double.maxFinite,
                          child: Container(
                              width: getHorizontalSize(370),
                              margin: getMargin(top: 10),
                              padding: getPadding(
                                  left: 20, top: 9, right: 20, bottom: 9),
                              decoration: AppDecoration.outlineBlack9003f
                                  .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder20),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("lbl_title".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtRobotoRomanBold20
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.15))),
                                    Padding(
                                        padding: getPadding(
                                            left: 8,
                                            top: 2,
                                            right: 27,
                                            bottom: 17),
                                        child: Text("msg_lorem_ipsum_dolor".tr,
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtRobotoRegular16
                                                .copyWith(
                                                    letterSpacing:
                                                        getHorizontalSize(
                                                            0.15))))
                                  ]))),
                      Container(
                          width: double.maxFinite,
                          child: Container(
                              width: getHorizontalSize(370),
                              margin: getMargin(top: 10),
                              padding: getPadding(
                                  left: 20, top: 9, right: 20, bottom: 9),
                              decoration: AppDecoration.outlineBlack9003f
                                  .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder20),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("lbl_title".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtRobotoRomanBold20
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.15))),
                                    Padding(
                                        padding: getPadding(
                                            left: 8,
                                            top: 2,
                                            right: 27,
                                            bottom: 17),
                                        child: Text("msg_lorem_ipsum_dolor".tr,
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtRobotoRegular16
                                                .copyWith(
                                                    letterSpacing:
                                                        getHorizontalSize(
                                                            0.15))))
                                  ]))),
                      Container(
                          width: double.maxFinite,
                          child: Container(
                              width: getHorizontalSize(370),
                              margin: getMargin(top: 10, bottom: 5),
                              padding: getPadding(
                                  left: 20, top: 9, right: 20, bottom: 9),
                              decoration: AppDecoration.outlineBlack9003f
                                  .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder20),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("lbl_title".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtRobotoRomanBold20
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.15))),
                                    Padding(
                                        padding: getPadding(
                                            left: 8,
                                            top: 2,
                                            right: 27,
                                            bottom: 17),
                                        child: Text("msg_lorem_ipsum_dolor".tr,
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtRobotoRegular16
                                                .copyWith(
                                                    letterSpacing:
                                                        getHorizontalSize(
                                                            0.15))))
                                  ])))
                    ]))));
  }

  onTapArrowleft() {
    Get.back();
  }
}
