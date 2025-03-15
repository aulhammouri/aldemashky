import 'package:ecommercecourse/controller/login_controller.dart';
import 'package:ecommercecourse/core/class/statusrequest.dart';
import 'package:ecommercecourse/core/functions/valid_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/imageassets.dart';
import '../../wedgets/custom_input_text_widget.dart';
import '../../wedgets/custom_btn_widget.dart';

class LoginScreenSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Container(
        color: Colors.white, // تأكد من إضافة لون للخلفية
        child: SingleChildScrollView(
          child: Form(
            key: controller.formStateLogin,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(height: 10),
                      GetBuilder<LoginControllerImp>(
                        builder: (controller) => SizedBox(
                          width: double.infinity,
                          child: CustomBtnWidget(
                            text: "Log In".tr,
                            onPressed: () {
                              controller.signIn();
                            },
                            isLoading: controller.statusRequest ==
                                    StatusRequest.loading
                                ? true
                                : false,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
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
        ));
  }
}
