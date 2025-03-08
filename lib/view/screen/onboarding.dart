import 'package:ecommercecourse/controller/onboarding_controller.dart';
import 'package:ecommercecourse/core/constant/colors.dart';
import 'package:ecommercecourse/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wedgets/custom_btn_widget.dart';

class OnBoarding extends GetView<OnboardingControllerImp> {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingControllerImp());
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (val) {
                    controller.onPageChanged(val);
                    //print(val);
                  },
                  itemCount: onBoardingList.length,
                  itemBuilder: (context, i) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Text(onBoardingList[i].title!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge),
                          const SizedBox(height: 30),
                          Image.asset(onBoardingList[i].image!, height: 250),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              onBoardingList[i].body!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      )),
            ),
            Expanded(
              flex: 1,
              child: GetBuilder<OnboardingControllerImp>(
                builder: (controller) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                            onBoardingList.length,
                            (i) => AnimatedContainer(
                                  margin: const EdgeInsets.only(right: 5),
                                  duration: const Duration(microseconds: 900),
                                  width: controller.currentPage == i ? 20 : 5,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: ColorApp.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                )),
                      ],
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomBtnWidget(
                            text: "continue".tr,
                            onPressed: () {
                              controller.next();
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
