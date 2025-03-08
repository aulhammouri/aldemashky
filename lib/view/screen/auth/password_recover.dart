import 'package:ecommercecourse/controller/password_recovery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/valid_input.dart';
import '../../wedgets/custom_input_text_widget.dart';
import '../../wedgets/custom_btn_widget.dart';

class PasswordRecover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PasswordRecoveryControllerImp controller =
        Get.put(PasswordRecoveryControllerImp());

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formState,
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
                        'Password Rcovery'.tr,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Password Rcovery Body'.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomInputTextWidget(
                        valid: (val) => validInput(val!, 8, 33, 'email'),
                        controller: controller.email,
                        text: "Email".tr,
                        hintText: "Enter Your Email".tr,
                        icon: Icon(Icons.email_outlined)),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    GetBuilder<PasswordRecoveryControllerImp>(
                      builder: (controller) => SizedBox(
                        width: double.infinity,
                        child: CustomBtnWidget(
                          text: "Recover".tr,
                          onPressed: () {
                            controller.recover();
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
                            controller.toSignup();
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
