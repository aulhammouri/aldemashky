import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/data/datasource/remote/categories_data.dart';
import 'package:ecommercecourse/data/model/category_ads_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../linkapi.dart';

abstract class CategoryAdsController extends GetxController {
  getMe();
  getCategories();
  getSubCategories(index);
  getAds(index);
}

class CategoryAdsControllerImp extends CategoryAdsController {
  MyServices myServices = Get.find();
  late String? user_email;
  bool? isLogedIn;
  bool? haveSubCategories;

  List categories = [];
  List subCategories = [];
  int selected_cat = 0;
  int selected_sub_cat = 0;

  late StatusRequest statusRequest = StatusRequest.none;
  CategoriesData data = CategoriesData(Get.find());

  @override
  void onInit() {
    getCategories();
    //getSubCategories(selected_cat);
    update();
    super.onInit();
  }

  @override
  getAds(index) {
    update();
  }

  @override
  getCategories() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(AppLink.catswithsubs, {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        categories.addAll(response['body']['data']);

        print(
            "+++++++++++++++++++++++++++++++++++++++++++++++ ${categories[0]['name']}");

        // snack(
        //     "Email Sent".tr,
        //     "Please check your email for recover your password".tr,
        //     Icons.done,
        //     'success');
        //Get.offNamed(AppRoutes.login);
      } else {
        snack("error".tr, "Server error".tr, Icons.error, 'info');
      }
    }
    update();
  }

  @override
  getMe() {
    user_email = myServices.sharedPreferences.getString("user_email");
    isLogedIn = myServices.sharedPreferences.getBool("isLogedIn");
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
}
