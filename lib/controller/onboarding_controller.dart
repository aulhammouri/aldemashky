import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:ecommercecourse/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OnboardingController extends GetxController {
  next();
  onPageChanged(val);
}

class OnboardingControllerImp extends OnboardingController {
  late PageController pageController;
  int currentPage = 0;

  @override
  next() {
    currentPage++;
    if (currentPage == onBoardingList.length) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      pageController.animateToPage(currentPage,
          duration: const Duration(microseconds: 9000),
          curve: Curves.easeInOut);
    }

    //print(currentPage);
  }

  @override
  onPageChanged(val) {
    currentPage = val;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
