import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../core/class/request_data.dart';
import '../core/services/services.dart';
import '../linkapi.dart';

abstract class ProductDetailController extends GetxController {
  getProduct(productId);
  getMoreComments(productId, page);
  callAuther(productId);
  whatsappAuthor(productId);
  initVedio();
  playPause();
}

class ProductDetailControllerImp extends ProductDetailController {
  MyServices myServices = Get.find();
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

  bool haveVideo = false;

  late VideoPlayerController vVcontroller;

  @override
  void onInit() async {
    await getProduct(productId); //1582 1603
    await initVedio();
    update();

    super.onInit();
  }

  @override
  getProduct(productId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(
        "${AppLink.getproduct}/$productId", {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        print("************************** ${response['body']['data']}");

        comments.addAll(response['body']['data']['comments']);
        product = response['body']['data'];
        commentsCount = int.parse(response['body']['data']['comments_count']);
        attachmentsCount = (response['body']['data']['attachments']).length;

        //statusRequest = StatusRequest.success;
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

  @override
  callAuther(productId) {
    // TODO: implement callAuther
    throw UnimplementedError();
  }

  @override
  getMoreComments(productId, page) {
    // TODO: implement getMoreComments
    throw UnimplementedError();
  }

  @override
  whatsappAuthor(productId) {
    // TODO: implement whatsappAuthor
    throw UnimplementedError();
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
