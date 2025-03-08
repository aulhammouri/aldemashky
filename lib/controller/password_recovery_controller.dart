import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:ecommercecourse/data/datasource/remote/password_recovery_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../linkapi.dart';

abstract class PasswordRecoveryController extends GetxController {
  recover();
  toSignup();
}

class PasswordRecoveryControllerImp extends PasswordRecoveryController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  PasswordRecoveryData data = PasswordRecoveryData(Get.find());
  late TextEditingController email;
  List responseData = [];
  late StatusRequest statusRequest = StatusRequest.none;

  @override
  recover() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await data.requestData(
          AppLink.passwordrecovery, {'email': email.text}, '', 'POST');
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['statusCode'] == 200) {
          snack(
              "Email Sent".tr,
              "Please check your email for recover your password".tr,
              Icons.done,
              'success');
          Get.offNamed(AppRoutes.login);
        } else if (response['statusCode'] == 404) {
          snack("Inputs error".tr, response['body']['message'], Icons.error,
              'info');
        }
      }
      update();
    }
  }

  @override
  toSignup() {
    Get.offNamed(AppRoutes.signup);
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
