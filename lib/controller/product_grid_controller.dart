import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../core/class/request_data.dart';
import '../core/services/services.dart';
import '../linkapi.dart';

abstract class ProductGridController extends GetxController {
  getMe();
  getCategories();
  getSubCategories(index);
  getAds(categoryId, page);
  getAdsFromScroll(categoryId, page);
}

class ProductGridControllerImp extends ProductGridController {
  MyServices myServices = Get.find();
  late String? user_email;
  bool? isLogedIn;
  bool? haveSubCategories;

  List categories = [
    {
      "id": 0,
      "name": "all".tr,
      "ads_count": 0,
      "children": [],
    },
  ];
  List subCategories = [];
  int selected_cat = 0;
  int selected_sub_cat = -1;
  List ads = [];
  late int adsCurrentPage = 1;
  late int adstotalPage = 1;
  late int categoryId = 0;
  bool isLoading = false;

  int gridColumnNumber = 2;
  Rx<Orientation> orientation = Rx<Orientation>(Get.mediaQuery.orientation);

  late StatusRequest statusRequest = StatusRequest.none;
  RequestData data = RequestData(Get.find());

  @override
  void onInit() {
    getCategories();
    getAds(0, 1);
    update();
    super.onInit();
  }

  @override
  getAds(categoryId, page) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(
        "${AppLink.adsfiltered}?category_id=$categoryId&page=$page",
        {},
        '',
        'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        print(response['body']['data']);
        print("************************** $categoryId");
        ads.addAll(response['body']['data']);
        adsCurrentPage = response['body']['current_page'];
        adstotalPage = response['body']['total_pages'];
        categoryId = categoryId;

        if (ads.length == 0) {
          statusRequest = StatusRequest.nodata;
        } else {
          statusRequest = StatusRequest.success;
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  getAdsFromScroll(categoryId, page) async {
    if (isLoading) return;
    isLoading = true;
    update();
    var response = await data.requestData(
        "${AppLink.adsfiltered}?category_id=$categoryId&page=$page",
        {},
        '',
        'GET');
    if (response['statusCode'] == 200) {
      ads.addAll(response['body']['data']);
      adsCurrentPage = response['body']['current_page'];
      adstotalPage = response['body']['total_pages'];
      categoryId = categoryId;
    } else {
      statusRequest = StatusRequest.failure;
    }
    isLoading = false;
    update();
  }

  @override
  getMe() {
    user_email = myServices.sharedPreferences.getString("user_email");
    isLogedIn = myServices.sharedPreferences.getBool("isLogedIn");
  }

  @override
  getCategories() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(AppLink.catswithsubs, {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        categories.addAll(response['body']['ad_cats']);
      } else {
        snack("error".tr, "Server error".tr, Icons.error, 'info');
      }
    }
    update();
  }

  @override
  getSubCategories(index) {
    if (categories[index]['children'].isNotEmpty) {
      haveSubCategories = true;
      subCategories = categories[index]['children'];
    } else {
      haveSubCategories = false;
    }
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
