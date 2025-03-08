import 'package:ecommercecourse/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/valid_input.dart';
import '../../wedgets/custom_input_text_widget.dart';
import '../../wedgets/custom_btn_widget.dart';

class SignupScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignupControllerImp());
    //SignupControllerImp controller = Get.put(SignupControllerImp());
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: ColorApp.primary,
          title: Text("sign up"),
          elevation: 1,
        ),
        body: GetBuilder<SignupControllerImp>(
          builder: (controller) => SingleChildScrollView(
            child: Form(
              key: controller.formStateSignup,
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
                            "Let's Get Started".tr,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'signup screan body'.tr,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomInputTextWidget(
                            valid: (val) => validInput(val!, 8, 33, 'username'),
                            controller: controller.username,
                            text: "UserName".tr,
                            hintText: "Enter Your User Name".tr,
                            icon: Icon(Icons.person_2_outlined)),
                        SizedBox(height: 20),
                        CustomInputTextWidget(
                            valid: (val) => validInput(val!, 8, 33, 'email'),
                            controller: controller.email,
                            text: "Email".tr,
                            hintText: "Enter Your Email".tr,
                            icon: Icon(Icons.email_outlined)),
                        SizedBox(height: 20),
                        CustomInputTextWidget(
                            valid: (val) => validInput(val!, 8, 33, 'phone'),
                            controller: controller.phone,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            text: "phone number".tr,
                            hintText: "Enter Your phone number".tr,
                            icon: Icon(Icons.email_outlined)),
                        SizedBox(height: 20),
                        CustomInputTextWidget(
                          valid: (val) => validInput(val!, 8, 33, 'password'),
                          controller: controller.password,
                          text: "Password".tr,
                          hintText: "Enter Your Password".tr,
                          icon: Icon(Icons.lock_outline),
                          obscure: controller.hideText,
                          onTapIcon: () {
                            controller.hideUnhideText();
                          },
                        ),
                        SizedBox(height: 20),
                        // CustomInputTextWidget(
                        //     valid: (val) => validInput(val!, 8, 33, 'password'),
                        //     controller: controller.repassword,
                        //     text: "Re Password".tr,
                        //     hintText: "Re Enter Your Password".tr,
                        //     icon: Icon(Icons.lock_outline)),
                        // SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: CustomBtnWidget(
                            text: "Sign Up".tr,
                            onPressed: () {
                              controller.signUp();
                            },
                            isLoading: controller.statusRequest ==
                                    StatusRequest.loading
                                ? true
                                : false,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Have an account?".tr),
                            TextButton(
                              onPressed: () {
                                controller.toLogin();
                              },
                              child: Text('sign in'.tr,
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
        ));
  }
}
