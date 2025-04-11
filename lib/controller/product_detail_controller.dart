import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../core/class/request_data.dart';
import '../core/services/services.dart';
import '../linkapi.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ProductDetailController extends GetxController {
  getProduct();
  getMoreComments();
  callAuther(phoneNumber);
  whatsappAuthor(whatsAppNumber, message);
  initVedio();
  playPause();
}

class ProductDetailControllerImp extends ProductDetailController {
  // MyServices myServices = Get.find();
  //int? userId;

  late String? user_email;
  bool? isLogedIn;
  bool? haveSubCategories;

  int productId = Get.arguments;
  Map product = {};
  List comments = [];
  int commentsCount = 0;
  late int commentsCurrentPage = 1;
  late int commentsTotalPage = 1;
  int attachmentsCount = 0;

  bool isLoading = false;

  late StatusRequest statusRequest = StatusRequest.none;
  RequestData data = RequestData(Get.find());

//video view
  bool haveVideo = false;
  late VideoPlayerController vVcontroller;

//review popup
  String comment = '';
  int rating = 0;

  @override
  void onInit() async {
    //userId = int.parse(myServices.sharedPreferences.getString("user_id"));
    await getProduct(); //1582 1603
    await initVedio();
    update();

    super.onInit();
  }

  @override
  getProduct() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(
        "${AppLink.getproduct}/$productId?foo=foo", {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        print("************************** ${response['body']['data']}");

        comments.addAll(response['body']['data']['comments']);
        product = response['body']['data'];
        commentsCount = int.parse(response['body']['data']['comments_count']);
        attachmentsCount = (response['body']['data']['attachments']).length;
        print("************************** ${product['video_url']}");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  @override
  void dispose() {
    vVcontroller.dispose();
    super.dispose();
  }

  bool loadingMoreComments = false;
  @override
  getMoreComments() async {
    if (commentsCount < commentsCurrentPage * 5) {
      snack("sorry".tr, "No more comments".tr, Icons.info, 'info');
      return;
    }
    loadingMoreComments = true;
    commentsCurrentPage = commentsCurrentPage + 1;
    update();
    var response = await data.requestData(
        "${AppLink.getmorecomment}?id=$productId&page=$commentsCurrentPage&per_page=5",
        {},
        '',
        'GET');
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        comments.addAll(response['body']['comments']);
        loadingMoreComments = false;
        update();
      }
    }
  }

  @override
  Future<void> callAuther(phone) async {
    final url = "tel:$phone";
    try {
      if (true) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      SnackBar(content: Text('Problem while open phone'.tr));
    }
  }

  @override
  Future<void> whatsappAuthor(phone, message) async {
    final url = 'https://wa.me/$phone?text=$message';
    try {
      if (true) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      SnackBar(content: Text('Proplem while open whatsapp'.tr));
    }
  }

  @override
  playPause() {
    vVcontroller.value.isPlaying ? vVcontroller.pause() : vVcontroller.play();
  }

  @override
  initVedio() {
    var url = product['video_url'];
    if (url != null && url.isNotEmpty) {
      haveVideo = true;
      vVcontroller =
          VideoPlayerController.networkUrl(Uri.parse(product['video_url']))
            ..initialize().then((_) {
              update();
            });
    } else {
      haveVideo = false;
    }
  }
}
