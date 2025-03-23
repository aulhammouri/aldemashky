import 'package:ecommercecourse/controller/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/request_data.dart';
import '../linkapi.dart';

class ReviewController extends GetxController {
  MyServices myServices = Get.find();
  ProductDetailControllerImp productDetailControllerImp =
      Get.put(ProductDetailControllerImp());

  String comment = ''; // لحفظ التعليق المدخل
  int rating = 0; // لحفظ التقييم المدخل
  Map newComment = {};

  RequestData data = RequestData(Get.find());
  late StatusRequest statusRequest = StatusRequest.none;

  Future<void> submitReview(int productId) async {
    if (comment != "" && rating > 0) {
      statusRequest = StatusRequest.loading;
      update();
      newComment = {
        'ad_post_id': productId,
        'author_id': myServices.sharedPreferences.getString("user_id"),
        'author': myServices.sharedPreferences.getString("user_nicename"),
        'content': comment,
        'review_stars': rating.toString()
      };
      var response =
          await data.requestData(AppLink.addcomment, newComment, '', 'POST');
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['statusCode'] == 200) {
          snack("Done".tr, response['body']['message'], Icons.check, 'success');

          productDetailControllerImp.comments.insert(0, newComment);
          productDetailControllerImp.update();
        } else {
          snack("alert".tr, response['body']['message'], Icons.error, 'info');
        }
        update();
      }

      comment = '';
      rating = 0;
      update();
    } else {
      print('يرجى ملء جميع الحقول');
    }
  }

  // دالة لتحديث التقييم
  void updateRating(int value) {
    rating = value;
    update(); // تحديث الواجهة بعد تغيير التقييم
  }

  void updateComment(String value) {
    comment = value;
    update(); // تحديث الواجهة بعد تغيير التعليق
  }
}
