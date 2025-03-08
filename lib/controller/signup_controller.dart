import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/constant/approutes.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../data/datasource/remote/signup_data.dart';
import '../linkapi.dart';

abstract class SignupController extends GetxController {
  signUp();
  toLogin();
  hideUnhideText();
}

class SignupControllerImp extends SignupController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController repassword;
  late bool hideText = true;
  SignupData data = SignupData(Get.find());

  List responseData = [];
  late StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> formStateSignup = GlobalKey<FormState>();

  @override
  signUp() async {
    var signupGlobalKey = formStateSignup.currentState;
    if (signupGlobalKey!.validate()) {
      var loginGlobalKey = formStateSignup.currentState;
      if (loginGlobalKey!.validate()) {
        statusRequest = StatusRequest.loading;
        update();
        var response = await data.requestData(
            AppLink.signup,
            {
              'username': username.text,
              'email': email.text,
              'password': password.text,
              'phone_number': phone.text
            },
            '',
            'POST');
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          if (response['statusCode'] == 200) {
            snack(
                "Done".tr, response['body']['message'], Icons.check, 'success');
            Get.offNamed(AppRoutes.login);
          } else if (response['statusCode'] == 403) {
            snack("Inputs error".tr, response['body']['message'], Icons.error,
                'info');
          }
          update();
        }
      }
////////////////////////
      print("valid");
    } else {
      print("not valid");
    }
  }

  @override
  toLogin() {
    Get.offNamed(AppRoutes.login);
  }

  @override
  hideUnhideText() {
    hideText = !hideText;
    update();
  }

  @override
  void onInit() {
    username = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    phone.dispose();
    email.dispose();
    password.dispose();
    repassword.dispose();

    super.dispose();
  }
}
