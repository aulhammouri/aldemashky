import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/view/wedgets/edit_review_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/request_data.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../linkapi.dart';

//import 'package:restart_app/restart_app.dart';

import '../view/wedgets/update_password_popup.dart';

abstract class ProductsMangingController extends GetxController {
  getAdsAndComments();
  getMoreAds();
  getMoreComments();
  updateAdStatus(adId, status);
  deleteAd(adId, index);
  editAd(adId, index);
  deleteComment(commentId, index);
  editComment(commentId, index);
  logOut();
  changeLanguage();
  updatePassword();
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
  int? selectedAdTile;
  List<dynamic> ads = [];

  List<dynamic> comments = [];
  final List<Map<String, dynamic>> statics = [
    {'icon': Icons.done, 'number': 35, 'title': 'active ads'.tr},
    {'icon': Icons.shopping_cart, 'number': 20, 'title': 'sold ads'.tr},
    {'icon': Icons.date_range, 'number': 5, 'title': 'expired ads'.tr},
  ];

  @override
  void onInit() {
    local = myServices.sharedPreferences.getString('local');
    userId = myServices.sharedPreferences.getString("user_id");
    userNicename = myServices.sharedPreferences.getString("user_nicename");
    getAdsAndComments();
    newpassword = TextEditingController();
    update();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  deleteAd(adId, index) async {
    print(adId);
    print(ads[index]);
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(
        AppLink.deleteproduct,
        {
          'post_id': adId,
        },
        '',
        'DELETE');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        snack("Done".tr, response['body']['message'], Icons.check, 'success');
        ads.removeAt(index);
      } else if (response['statusCode'] == 403 ||
          response['statusCode'] == 404) {
        snack("Inputs error".tr, response['body']['message'], Icons.error,
            'info');
      }
      update();
    }
  }

  @override
  deleteComment(commentId, index) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(
        AppLink.deletecomment,
        {
          'comment_id': commentId,
        },
        '',
        'DELETE');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        snack("Done".tr, response['body']['message'], Icons.check, 'success');
        comments.removeAt(index);
      } else if (response['statusCode'] == 403) {
        snack("Inputs error".tr, response['body']['message'], Icons.error,
            'info');
      }
      update();
    }
  }

  int adsPage = 1;
  int totalAdsCount = 0;
  int commentsPage = 1;
  int totalCommentsCount = 0;

  @override
  getMoreAds() async {
    if (adsPage * 5 > totalAdsCount) {
      snack("sorry".tr, "No more ads".tr, Icons.info, 'info');
      return;
    }
    adsPage = adsPage + 1;
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(
        "${AppLink.usermoreads}/$userId?page=$adsPage", {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        ads.addAll(response['body']['ads']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
  }

  @override
  getMoreComments() async {
    if (commentsPage * 5 > totalCommentsCount) {
      snack("sorry".tr, "No more comments".tr, Icons.info, 'info');
      return;
    }
    commentsPage = commentsPage + 1;
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(
        "${AppLink.usermorecomments}/$userId?page=$commentsPage",
        {},
        '',
        'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        comments.addAll(response['body']['comments']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
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

        totalAdsCount = response['body']['total_ads_count'];
        totalCommentsCount = response['body']['total_comments_count'];
        adsPage = 1;
        commentsPage = 1;
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

  int? ratingEdit;
  String? commentEdit;
  int? commentIndex;
  int? commentId;
  @override
  void editComment(cId, index) {
    print(cId);
    commentIndex = index;
    commentId = int.parse(cId);
    commentEdit = comments[index]['title'];
    ratingEdit = int.parse(comments[index]['review_star']);
    Get.dialog(EditReviewPopup()); //comment: comments[index]));
  }

  void updateRating(int value) {
    ratingEdit = value;
    update();
  }

  void updateCommentText(String value) {
    commentEdit = value;
    update();
  }

  void updateComment() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(
        AppLink.editcomment,
        {
          'comment_id': commentId,
          'content': commentEdit,
          'review_stars': ratingEdit.toString()
        },
        '',
        'POST');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        comments[commentIndex!]['title'] = commentEdit;
        comments[commentIndex!]['review_star'] = ratingEdit.toString();
        snack("Done".tr, response['body']['message'], Icons.check, 'success');
      } else if (response['statusCode'] == 403) {
        snack("Inputs error".tr, response['body']['message'], Icons.error,
            'info');
      }
      update();
    }

    update();
  }

  // @override
  // logOut() {
  //   myServices.sharedPreferences.setBool('isLogedIn', false);
  //   Get.offAllNamed(AppRoutes.login);
  // }

  String? local;

  @override
  changeLanguage() {
    //print(Locale('ar'));
    if (local == "ar") {
      myServices.sharedPreferences.setString('local', 'en');
      local = 'en';
      Get.updateLocale(Locale('en'));
    } else {
      myServices.sharedPreferences.setString('local', 'ar');
      local = 'ar';

      Get.updateLocale(Locale('ar'));
    }

    //Restart.restartApp();
    print(local);
  }

  late bool hideText = true;
  TextEditingController? newpassword;

  hideUnhideText() {
    hideText = !hideText;
    update();
  }

  updatePasswordPopup() {
    Get.dialog(UpdatePasswordPopup());
  }

  @override
  updatePassword() async {
    if (newpassword!.text == "" || newpassword!.text.length < 8) {
      snack("Info".tr, "يجب ان تكون كلمة السر لا تقل عن 8 أحرف", Icons.check,
          'Info');
    } else {
      statusRequest = StatusRequest.loading;
      update();
      var response = await data.requestData(
          AppLink.updatepassword,
          {
            'user_id': myServices.sharedPreferences.getString("user_id"),
            'new_password': newpassword!.text,
          },
          '',
          'POST');
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['statusCode'] == 200) {
          snack("Done".tr, response['body']['message'], Icons.check, 'success');
        } else if (response['statusCode'] == 403) {
          snack("Inputs error".tr, response['body']['message'], Icons.error,
              'info');
        }
      }
      update();

      print(newpassword!.text);
      newpassword = TextEditingController();
    }
  }

  @override
  void logOut() {
    Get.defaultDialog(
      title: "تأكيد تسجيل الخروج",
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      middleText: "هل أنت متأكد أنك تريد تسجيل الخروج؟",
      middleTextStyle: TextStyle(fontSize: 14),
      backgroundColor: Colors.white,
      radius: 15,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("إلغاء", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            myServices.sharedPreferences.setBool('isLogedIn', false);
            Get.offAllNamed(AppRoutes.login);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text(
            "تأكيد",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
