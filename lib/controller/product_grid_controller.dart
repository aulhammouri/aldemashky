import 'package:ecommercecourse/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../core/class/request_data.dart';
import '../linkapi.dart';

abstract class ProductGridController extends GetxController {
  getCats10Ads();

  getSubCategories(index);
  //getAds(categoryId, page);
  //getAdsFromScroll(categoryId, page);
}

class ProductGridControllerImp extends ProductGridController {
  MyServices myServices = Get.find();
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
  // ignore: non_constant_identifier_names
  int selected_cat = 0;
  // ignore: non_constant_identifier_names
  int selected_sub_cat = -1;
  List ads = [];
  late int adsCurrentPage = 1;
  late int adstotalPage = 1;
  int categoryId = 0;

  bool isLoading = false;

  int gridColumnNumber = 2;
  Rx<Orientation> orientation = Rx<Orientation>(Get.mediaQuery.orientation);

  late StatusRequest statusRequest = StatusRequest.none;
  RequestData data = RequestData(Get.find());

  @override
  void onInit() {
    searchWorld = TextEditingController();
    minPrice = TextEditingController();
    maxPrice = TextEditingController();
    searchLocation = TextEditingController();
    beforedate = TextEditingController();
    afterdate = TextEditingController();
    getCats10Ads();
    // getAds(0, 1);
    update();
    super.onInit();
  }

  @override
  void dispose() {
    searchWorld!.dispose();
    minPrice!.dispose();
    maxPrice!.dispose();
    searchLocation!.dispose();
    super.dispose();
  }

  TextEditingController? searchWorld;
  TextEditingController? minPrice;
  TextEditingController? maxPrice;
  TextEditingController? searchLocation;
  TextEditingController? afterdate;
  TextEditingController? beforedate;
  String? conditionSearch = "";
  String? ad_type = "";
  String? warranty = "";
  String? order = "desc";
  String? orderby = "date";

  getAds(catId, page) async {
    statusRequest = StatusRequest.loading;
    update();
    print(
        "${AppLink.adsfiltered}?category_id=$catId&page=$page&ad_title=${searchWorld?.text}&condition=$conditionSearch&ad_type=$ad_type&warranty=$warranty&min_price=${minPrice?.text}&max_price=${maxPrice?.text}&location=${searchLocation?.text}&order=$order&orderby=$orderby&afterdate=${afterdate?.text}&beforedate=${beforedate?.text}");
    var response = await data.requestData(
        "${AppLink.adsfiltered}?category_id=$catId&page=$page&ad_title=${searchWorld?.text}&condition=$conditionSearch&ad_type=$ad_type&warranty=$warranty&min_price=${minPrice?.text}&max_price=${maxPrice?.text}&location=${searchLocation?.text}&order=$order&orderby=$orderby&afterdate=${afterdate?.text}&beforedate=${beforedate?.text}",
        {},
        '',
        'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        print(response['body']);
        print("************************** $catId");
        ads.addAll(response['body']['data']);
        adsCurrentPage = response['body']['current_page'];
        adstotalPage = response['body']['total_pages'];
        categoryId = catId;
        if (ads.length > 0) {
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.nodata;
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  getAdsFromScroll(categoryId, page) async {
    if (isLoading) return;
    isLoading = true;
    update();
    var response = await data.requestData(
        "${AppLink.adsfiltered}?category_id=$categoryId&page=$page&ad_title=${searchWorld?.text}&condition=$conditionSearch&ad_type=$ad_type&warranty=$warranty&min_price=${minPrice?.text}&max_price=${maxPrice?.text}&location=${searchLocation?.text}&order=$order&orderby=$orderby&afterdate=${afterdate?.text}&beforedate=${beforedate?.text}",
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
  getCats10Ads() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(AppLink.cats10ads, {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        categories.addAll(response['body']['ad_cats']);
        ads.addAll(response['body']['ads']);
        adstotalPage = response['body']['total_pages'];
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

  Future<void> selectDateTime(BuildContext context, beforAfter) async {
    DateTime now = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate == null) return;
    DateTime finalDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    if (beforAfter == "before") {
      beforedate?.text =
          "${finalDateTime.year}-${finalDateTime.month.toString().padLeft(2, '0')}-${finalDateTime.day.toString().padLeft(2, '0')}";
    }
    if (beforAfter == "after") {
      afterdate?.text =
          "${finalDateTime.year}-${finalDateTime.month.toString().padLeft(2, '0')}-${finalDateTime.day.toString().padLeft(2, '0')}";
    }
    update();
  }

  checkOrder() {
    if (orderby == "date" && order == "desc") {
      return true;
    } else {
      return false;
    }
  }

  filter() {
    print(searchWorld!.text);
    print(minPrice!.text);
    print(maxPrice!.text);
    print(searchLocation!.text);
    print(conditionSearch);
    print(ad_type);
    print(warranty);
  }

  checkFilter() {
    if (searchWorld!.text == "" &&
        minPrice!.text == "" &&
        maxPrice!.text == "" &&
        searchLocation!.text == "" &&
        conditionSearch == "" &&
        ad_type == "" &&
        warranty == "") {
      return true;
    } else {
      return false;
    }
  }
}
