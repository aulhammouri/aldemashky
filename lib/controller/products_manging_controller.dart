import 'package:ecommercecourse/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/request_data.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/imageassets.dart';
import '../core/functions/handingdatacontroller.dart';
import '../linkapi.dart';

abstract class ProductsMangingController extends GetxController {
  getAdsAndComments();
  getMoreAds();
  getMoreComments();
  makeAdActive(adId);
  deleteAd(adId);
  editAd(adId);
  deleteComment(commentId);
  makeAdSold(ad);
  makeAdExpired(ad);
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
  List<dynamic> ads = [
    //   {
    //     "id": "1",
    //     'title': "عنوان اعلان 1",
    //     'image': 'url',
    //     'status': "active",
    //     'date': "منذ 10 أيام",
    //   },
    //   {
    //     "id": "2",
    //     'title': "عنوان اعلان 2",
    //     'image': 'url',
    //     'status': "sold",
    //     'date': "منذ 10 أيام",
    //   },
    //   {
    //     "id": "3",
    //     'title': "عنوان اعلان 3",
    //     'image': 'url',
    //     'status': "expired",
    //     'date': "منذ 10 أيام",
    //   },
    //   {
    //     "id": "4",
    //     'title': "عنوان اعلان 4",
    //     'image': 'url',
    //     'status': "active",
    //     'date': "10 أيام",
    //   },
  ];

  List<dynamic> comments = [
    //   {
    //     "id": "1",
    //     'title': "نص تعليق 1",
    //     'date': "منذ 10 أيام",
    //     'product': "توصيل",
    //   },
    //   {
    //     "id": "2",
    //     'title': "نص تعليق 2",
    //     'date': "منذ 10 أيام",
    //     'product': "توصيل",
    //   },
    //   {
    //     "id": "3",
    //     'title': "نص تعليق 3",
    //     'date': "منذ 10 أيام",
    //     'product': "توصيل",
    //   },
    //   {
    //     "id": "4",
    //     'title': "نص تعليق 4",
    //     'date': "10 أيام",
    //     'product': "توصيل",
    //   },
  ];
  final List<Map<String, dynamic>> statics = [
    {
      'image': ImageAssets.carousel3,
      'icon': Icons.done,
      'number': 35,
      'title': 'اعلاناتي النشطة'
    },
    {
      'image': ImageAssets.carousel3,
      'icon': Icons.shopping_cart,
      'number': 20,
      'title': 'اعلاناتي المباعة'
    },
    {
      'image': ImageAssets.carousel3,
      'icon': Icons.date_range,
      'number': 5,
      'title': 'اعلاناتي المنتهية'
    },
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
  deleteAd(adId) {
    ads = [];
    update();
  }

  @override
  deleteComment(commentId) {
    // TODO: implement deleteComment
    throw UnimplementedError();
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
  makeAdExpired(ad) {
    // TODO: implement makeAdExpired
    throw UnimplementedError();
  }

  @override
  makeAdSold(ad) {
    // TODO: implement makeAdSold
    throw UnimplementedError();
  }

  @override
  editAd(adId) {
    // TODO: implement editAd
    throw UnimplementedError();
  }

  @override
  makeAdActive(adId) {
    // TODO: implement makeAdActive
    throw UnimplementedError();
  }

  void editComment(comment) {}
}
