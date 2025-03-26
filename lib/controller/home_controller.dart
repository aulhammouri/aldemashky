import 'dart:async';

import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/linkapi.dart';
import 'package:ecommercecourse/view/wedgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/request_data.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/imageassets.dart';
import '../core/functions/handingdatacontroller.dart';
import '../view/screen/product_grid_page.dart';

abstract class HomeController extends GetxController {
  getAdsLists();
  initCarosel();
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();
  late StatusRequest statusRequest = StatusRequest.none;
  RequestData data = RequestData(Get.find());

  List newestAds = [];
  List mostViewedAds = [];
  List cheapestAds = [];
  List featuredAds = [];

  @override
  void onInit() {
    getAdsLists();
    pageController = PageController();
    initCarosel();
    update();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  getAdsLists() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(AppLink.mainads, {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        newestAds.addAll(response['body']['latest']);
        mostViewedAds.addAll(response['body']['most_viewed']);
        cheapestAds.addAll(response['body']['cheapest']);
        featuredAds.addAll(response['body']['featured']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  int currentIndex = 0;

  final List<Map<String, dynamic>> images = [
    {
      'image': ImageAssets.carousel3,
      'icon': Icons.handshake,
      'number': 1042,
      'title': 'زبون سعيد'
    },
    {
      'image': ImageAssets.carousel2,
      'icon': Icons.star,
      'number': 500,
      'title': 'تقييم عالي'
    },
    {
      'image': ImageAssets.carousel1,
      'icon': Icons.shopping_cart,
      'number': 2000,
      'title': 'مبيعات ناجحة'
    },
  ];
  PageController pageController = PageController();

  @override
  initCarosel() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (currentIndex < images.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      pageController.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}
