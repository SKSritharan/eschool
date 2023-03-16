import 'dart:io';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_datepicker.dart';
import '../../widgets/custom_imagepicker.dart';
import 'controller/add_employee_controller.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/core/utils/validation_functions.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AddEmployeeScreen extends GetWidget<AddEmployeeController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddEmployeeController submitControllerEmployee =
      Get.put(AddEmployeeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.blue50,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 60,
                leading: AppbarImage(
                    height: getVerticalSize(17),
                    width: getHorizontalSize(30),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 30, top: 54, bottom: 27),
                    onTap: onTapArrowleft7),
                centerTitle: true,
                title: AppbarTitle(
                    text: "lbl_add_employee".tr,
                    margin: getMargin(top: 55, bottom: 18)),
                styleType: Style.bgFillBluegray700),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: getPadding(left: 48, top: 62, right: 48),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                  height: getVerticalSize(105),
                                  width: getHorizontalSize(100),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: getVerticalSize(105),
                                            width: getHorizontalSize(100),
                                            child: CustomImagePicker(
                                              onImageSelected: (File image) {
                                                // pass the selected image to the add teacher controller
                                                submitControllerEmployee
                                                    .uploadEmployeeImage(image);
                                              },
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                      ]))),
                          Text("lbl_name".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsMedium14),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: controller.employeeNameController,
                              hintText: "lbl_full_name".tr,
                              margin: getMargin(top: 2),
                              validator: (value) {
                                if (!isText(value)) {
                                  return "Please enter valid text";
                                }
                                return null;
                              }),
                          Padding(
                              padding: getPadding(top: 18),
                              child: Text("lbl_email".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsMedium14)),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: controller.employeeEmailController,
                              hintText: "lbl_email_address".tr,
                              margin: getMargin(top: 2),
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    (!isValidEmail(value, isRequired: true))) {
                                  return "Please enter valid email";
                                }
                                return null;
                              }),
                          Padding(
                              padding: getPadding(top: 15),
                              child: Text("lbl_phone_number".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsMedium14)),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: controller.employeePhoneController,
                              hintText: "lbl_phone_number".tr,
                              margin: getMargin(top: 5),
                              textInputType: TextInputType.phone,
                              validator: (value) {
                                if (!isValidPhone(value)) {
                                  return "Please enter valid phone number";
                                }
                                return null;
                              }),
                          Padding(
                            padding: getPadding(top: 18),
                            child: Text("lbl_date_of_birth".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsMedium14),
                          ),
                          CustomDatePicker(
                            textEditingController:
                                controller.employeeDobController,
                          ),
                          Spacer(),
                          CustomButton(
                              height: getVerticalSize(45),
                              text: "lbl_save".tr,
                              margin: getMargin(left: 42, top: 50, right: 42),
                              fontStyle: ButtonFontStyle.RalewayBold20,
                              onTap: onTapSubmit)
                        ])))));
  }

  onTapArrowleft7() {
    Get.back();
  }

  onTapSubmit() {
    submitControllerEmployee.createEmployeeAccount();
  }
}
