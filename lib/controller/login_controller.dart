import 'package:ecommercecourse/core/functions/snack.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/constant/approutes.dart';
import '../core/functions/handingdatacontroller.dart';
import '../data/datasource/remote/login_data.dart';

abstract class LoginController extends GetxController {
  signIn();
  goToSignup();
  gotToRecoverScrean();
  hideUnhideText();
}

class LoginControllerImp extends LoginController {
  late TextEditingController email;
  late TextEditingController password;
  late bool hideText = true;

  MyServices myService = Get.find();
  LoginData data = LoginData(Get.find());

  List responseData = [];
  late StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> formStateLogin = GlobalKey<FormState>();

  @override
  signIn() async {
    var loginGlobalKey = formStateLogin.currentState;
    if (loginGlobalKey!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await data.requestData(AppLink.login,
          {'username': email.text, 'password': password.text}, '', 'POST');
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['statusCode'] == 200) {
          myService.sharedPreferences
              .setString("token", response['body']['token']);
          myService.sharedPreferences
              .setString("user_email", response['body']['user_email']);
          myService.sharedPreferences
              .setString("user_nicename", response['body']['user_nicename']);
          myService.sharedPreferences.setString(
              "user_display_name", response['body']['user_display_name']);
          //myService.sharedPreferences.setStringList("roles", response['body']['roles']);
          myService.sharedPreferences
              .setString("user_id", response['body']['store_id'].toString());
          myService.sharedPreferences.setBool("isLogedIn", true);
          Get.toNamed(AppRoutes.homepage);
        } else if (response['statusCode'] == 403) {
          snack("Inputs error".tr, response['body']['message'], Icons.error,
              'info');
        }
      }
      update();
    }
  }

  @override
  goToSignup() {
    Get.offNamed(AppRoutes.signup);
  }

  @override
  gotToRecoverScrean() {
    Get.toNamed(AppRoutes.passwordrecover);
  }

  @override
  hideUnhideText() {
    hideText = !hideText;
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
