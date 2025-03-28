import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/request_data.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../linkapi.dart';

abstract class ProductsMangingController extends GetxController {
  getAdsAndComments();
  getMoreAds();
  getMoreComments();
  updateAdStatus(adId, status);
  deleteAd(adId, index);
  editAd(adId, index);
  deleteComment(commentId, index);
  editComment(commentId, index);
}

class ProductsMangingControllerImp extends ProductsMangingController {
  MyServices myServices = Get.find();
  String? userId;
  String? userNicename;
  //List ads = [];
  int currentAdsPage = 1;
  int currentCommentsPage = 1;
  late StatusRequest statusRequest = StatusRequest.none;
  RequestData data = RequestData(Get.find());
  Map<String, dynamic> adscount = {};
  // GlobalKey<FormState> formStateSignup = GlobalKey<FormState>();

  List<dynamic> ads = [];

  List<dynamic> comments = [];
  final List<Map<String, dynamic>> statics = [
    {'icon': Icons.done, 'number': 35, 'title': 'active ads'.tr},
    {'icon': Icons.shopping_cart, 'number': 20, 'title': 'sold ads'.tr},
    {'icon': Icons.date_range, 'number': 5, 'title': 'expired ads'.tr},
  ];

  @override
  void onInit() {
    userId = myServices.sharedPreferences.getString("user_id");
    userNicename = myServices.sharedPreferences.getString("user_nicename");
    getAdsAndComments();
    update();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  deleteAd(adId, index) {
    ads.removeAt(index);
    update();
  }

  @override
  deleteComment(commentId, index) {
    comments.removeAt(index);
    update();
  }

  @override
  getMoreAds() {
    // TODO: implement getMoreAds
    throw UnimplementedError();
  }

  @override
  getMoreComments() {
    // TODO: implement getMoreComments
    throw UnimplementedError();
  }

  @override
  getAdsAndComments() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await data.requestData("${AppLink.userads}/$userId", {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        ads.addAll(response['body']['ads']);
        comments.addAll(response['body']['comments']);
        adscount.addAll(response['body']['ads_count']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
  }

  @override
  editAd(adId, index) {
    Get.toNamed(AppRoutes.editproduct, arguments: adId);
  }

  @override
  updateAdStatus(adId, status) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(AppLink.updateadstatus,
        {'post_id': adId, 'status': status}, '', 'POST');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        var oldStatus = ads[ads.indexWhere((ad) => ad['id'] == adId)]['status'];
        adscount[oldStatus] = adscount[oldStatus] - 1;
        adscount[status] = adscount[status] + 1;
        ads[ads.indexWhere((ad) => ad['id'] == adId)]['status'] = status;

        snack("Done".tr, response['body']['message'], Icons.check, 'success');
      } else if (response['statusCode'] == 403) {
        snack("Inputs error".tr, response['body']['message'], Icons.error,
            'info');
      }
      update();
    }
  }

  @override
  void editComment(commentId, index) {}
}
