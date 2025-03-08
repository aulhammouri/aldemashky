import 'package:ecommercecourse/controller/login_controller.dart';
import 'package:ecommercecourse/core/class/statusrequest.dart';
import 'package:ecommercecourse/core/functions/valid_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/imageassets.dart';
import '../../wedgets/custom_input_text_widget.dart';
import '../../wedgets/custom_btn_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formStateLogin,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageAssets.logo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Welcome back!'.tr,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'login screan body'.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomInputTextWidget(
                        controller: controller.email,
                        valid: (val) => validInput(val!, 5, 33, 'email'),
                        text: "Email".tr,
                        hintText: "Enter Your Email".tr,
                        icon: Icon(Icons.email_outlined)),
                    SizedBox(height: 20),
                    GetBuilder<LoginControllerImp>(
                      builder: (controller) => CustomInputTextWidget(
                          valid: (val) => validInput(val!, 8, 33, 'password'),
                          controller: controller.password,
                          obscure: controller.hideText,
                          onTapIcon: () {
                            controller.hideUnhideText();
                          },
                          text: "Password".tr,
                          hintText: "Enter Your Password".tr,
                          icon: Icon(Icons.lock_outline)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.gotToRecoverScrean();
                          },
                          child: Text('Forgot password?'.tr,
                              style: TextStyle(color: Colors.green)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    GetBuilder<LoginControllerImp>(
                      builder: (controller) => SizedBox(
                        width: double.infinity,
                        child: CustomBtnWidget(
                          text: "Log In".tr,
                          onPressed: () {
                            controller.signIn();
                          },
                          isLoading:
                              controller.statusRequest == StatusRequest.loading
                                  ? true
                                  : false,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?".tr),
                        TextButton(
                          onPressed: () {
                            controller.goToSignup();
                          },
                          child: Text('sign up'.tr,
                              style: TextStyle(color: Colors.green)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
