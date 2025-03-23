import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/linkapi.dart';
import 'package:ecommercecourse/view/wedgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/request_data.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../view/screen/product_grid_page.dart';

abstract class HomeController extends GetxController {
  getAdsLists();
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
    update();
    super.onInit();
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
}
