import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz_unsafe.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/class/request_data.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/approutes.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/functions/snack.dart';
import '../linkapi.dart';

abstract class EditProductController extends GetxController {
  getLists();
  getProduct();
  editProduct();
  addImageToProduct();
  updateSubCategories(Map<String, dynamic> category);
  updateCondition(String value);
  updateWarranty(String value);
  updateType(String value);
  updatePricType(Map<String, String> priceType);
  updateCurrency(String value);
}

class EditProductControllerImp extends EditProductController {
  MyServices myservice = Get.find();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? token;
  String? poster_name;
  String? userId;

  int productId = Get.arguments ?? 0;
  Map product = {};
  List attachments = [];
  int attachmentsCount = 0;

  final ImagePicker _picker = ImagePicker();
  File file = File("");
  //late TextEditingController category;
  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController price;
  late TextEditingController poster_contact;

  late TextEditingController bidding_date;
  late TextEditingController location;

  List responseData = [];
  late StatusRequest statusRequest = StatusRequest.none;
  RequestData data = RequestData(Get.find());

  @override
  void onInit() async {
    token = myservice.sharedPreferences.getString('token');
    poster_name = myservice.sharedPreferences.getString('user_nicename');
    userId = myservice.sharedPreferences.getString('user_id');
    //category = TextEditingController();
    poster_contact = TextEditingController();
    title = TextEditingController();
    description = TextEditingController();
    price = TextEditingController();
    bidding_date = TextEditingController();
    location = TextEditingController();
    tagInput = TextEditingController();
    await getLists();
    await getProduct();
    super.onInit();
  }

  @override
  void dispose() {
    product = {};
    super.dispose();
  }

  @override
  editProduct() async {
    var addProductGlobalKey = formState.currentState;
    if (addProductGlobalKey!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await data.requestMultipartData(
          AppLink.editproduct,
          {
            "id": productId,
            "user_id": myservice.sharedPreferences.getString('user_id'),
            "category": selectedSubCategory != null
                ? selectedSubCategory!['id']
                : selectedMainCategory!['id'],
            "poster_contact": poster_contact.text,
            "poster_name":
                myservice.sharedPreferences.getString('user_display_name'),
            "title": title.text,
            "description": description.text,
            "price_type": priceType?['db'],
            "price": price.text,
            "currency": currency,
            "bidding_date": bidding_date.text,
            "bidding": priceType?['db'] == "auction" ? "1" : "0",
            "location": location.text,
            'countryId': selectedMainCountry?['id'],
            'subcountryId': selectedSubCountry?['id'],
            "map_long": "",
            "map_lat": "",
            "warranty": warranty,
            "condition": condition,
            "type": type,
            "tags": tags
          },
          file,
          token,
          'POST');
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['statusCode'] == 200) {
          snack("Done".tr, response['body']['message'], Icons.check, 'success');
          Get.offNamed(AppRoutes.homepage,
              arguments: response['body']['post_id']);
        } else if (response['statusCode'] == 403) {
          snack("Inputs error".tr, response['body']['message'], Icons.error,
              'info');
        }
        update();
      }
      print("valid");
    } else {
      print("not valid");
    }
  }

  Future<void> choseImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = File(pickedFile.path);
      update();
    }
  }

//send image to server
  Future<void> saveOnotherImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = File(pickedFile.path);
      statusRequest = StatusRequest.loading;
      update();
      var response = await data.requestMultipartData(
          AppLink.addfile,
          {
            "post_id": productId,
            "post_author": userId,
          },
          file!,
          token,
          'POST');
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['statusCode'] == 200) {
          snack("Done".tr, response['body']['message'], Icons.check, 'success');
          attachments.add({
            "id": response['body']['attachment_id'],
            "url": response['body']['file_url'],
          });
        } else {
          snack("Error".tr, "server error".tr, Icons.error, 'info');
        }
        update();
      }

      update();
    }
  }

  removeImage(image) {
    //remove image from server
    attachments.remove(image);
    print(image["id"]);
    update();
  }

  Future<void> deleteVedio(url) async {
    print(url);
    update();
  }

  Future<void> saveVedio() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = File(pickedFile.path);
      statusRequest = StatusRequest.loading;
      update();
      var response = await data.requestMultipartData(AppLink.addfile,
          {"post_id": productId, "post_author": userId}, file!, token, 'POST');
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['statusCode'] == 200) {
          snack("Done".tr, response['body']['message'], Icons.check, 'success');
          product['video_url'] = response['body']['file_url'];
        } else {
          snack("Error".tr, "server error".tr, Icons.error, 'info');
        }
        update();
      }
    }
  }

  @override
  addImageToProduct() {
    // TODO: implement addImageToProduct
    throw UnimplementedError();
  }

  Map<String, dynamic>? findElementAndParentById(List<dynamic> data, int id,
      {Map<String, dynamic>? parent}) {
    for (var item in data) {
      if (item["id"] == id) {
        return {"child": item, "parent": parent};
      }
      if (item["children"] != null && item["children"].isNotEmpty) {
        var result =
            findElementAndParentById(item["children"], id, parent: item);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

  Map<String, dynamic>? category;
  final List<dynamic> categories = [];
  Map<String, dynamic>? selectedMainCategory;
  Map<String, dynamic>? selectedSubCategory;

  @override
  void updateSubCategories(Map<String, dynamic> category) {
    selectedMainCategory = category;
    selectedSubCategory = null;
    if (selectedMainCategory!['name'] == 'توصیل' ||
        selectedMainCategory!['name'] == 'خدمات' ||
        selectedMainCategory!['name'] == 'طبي' ||
        selectedMainCategory!['name'] == 'مھن واعمال حرة') {
      isCatService = true;
    } else {
      isCatService = false;
    }
    update();
    print(selectedMainCategory);
    print(selectedSubCategory);
  }

  final List<dynamic> countries = [];
  bool isCatService = false;

  Map<String, dynamic>? selectedMainCountry;
  Map<String, dynamic>? selectedSubCountry;

  void updateMainCountry(Map<String, dynamic> Country) {
    selectedMainCountry = Country;
    selectedSubCountry = null;
    print(selectedMainCountry);
    print(selectedSubCountry);
    update();
  }

  void updateSubCountry(Map<String, dynamic> sCountry) {
    selectedSubCountry = sCountry;
    print(selectedMainCountry);
    print(selectedSubCountry);

    update();
  }

  final List<dynamic> conditionListMap = [];
  final List<dynamic> conditionList = [];
  String? condition;

  @override
  void updateCondition(String value) {
    condition = value;
    update(); // تحديث الواجهة
  }

  final List<dynamic> warrantyListMap = [];
  final List<String> warrantyList = [];
  String? warranty;
  @override
  void updateWarranty(String value) {
    warranty = value;
    update(); // تحديث الواجهة
  }

  String? type;
  final List<dynamic> typeListMap = [];
  final List<String> typeList = [];
  @override
  void updateType(String value) {
    type = value;
    update(); // تحديث الواجهة
  }

  String? currency;
  final List<dynamic> currencyListMap = [];
  final List<String> currencyList = [];
  @override
  void updateCurrency(String value) {
    currency = value;
    update();
  }

//priceType
  Map<String, String>? priceType;
  final List<Map<String, String>> priceTypeList = [
    {
      "db": "Fixed",
      "viewed": "ثابت",
    },
    {
      "db": "Negotiable",
      "viewed": "قابل للتفاوض",
    },
    {
      "db": "on_call",
      "viewed": "السعر عند الاتصال",
    },
    {
      "db": "auction",
      "viewed": "مزاد علني",
    },
    {
      "db": "free",
      "viewed": "مجاني",
    },
  ];
  @override
  updatePricType(Map<String, String> value) {
    priceType = value;
    update();
  }

//tags
  late TextEditingController tagInput;
  List<String> tags = [];
  addTag(String tag) {
    if (tag != "") {
      tags.add(tag);
      tagInput.text = "";
      update();
    }
  }

  removeTag(String tag) {
    tags.remove(tag);
    update();
  }

//aprovement
  bool approveConditionStatus = false;
  approveCondition(bool value) {
    approveConditionStatus = value;
    update();
  }

  Future<void> selectDateTime(BuildContext context) async {
    DateTime now = DateTime.now();

    // اختيار التاريخ
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) return; // المستخدم لم يختر أي تاريخ

    // اختيار الوقت
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) return; // المستخدم لم يختر أي وقت

    // دمج التاريخ والوقت
    DateTime finalDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    bidding_date.text =
        "${finalDateTime.year}-${finalDateTime.month.toString().padLeft(2, '0')}-${finalDateTime.day.toString().padLeft(2, '0')} "
        "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
    update();
  }

  @override
  getProduct() async {
    statusRequest = StatusRequest.loading;
    var response = await data.requestData(
        "${AppLink.getproduct}/$productId", {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        print("************************** ${response['body']['data']}");
        product = response['body']['data'];
        for (var tag in product['tags']) {
          tags.add(tag);
        }

        attachments = response['body']['data']['attachments'];
        attachmentsCount = (response['body']['data']['attachments']).length;
        poster_contact.text = product['poster_contact'];
        title.text = product['title'];
        description.text = product['content'];
        location.text = product['location'];
        bidding_date.text = product['bidding_date'];
        price.text = product['price'];

        condition =
            conditionList.indexWhere((v) => v == product['condition']) != -1
                ? product['condition']
                : null;
        priceType =
            priceTypeList.indexWhere((v) => v['db'] == product['price_type']) !=
                    -1
                ? priceTypeList[priceTypeList
                    .indexWhere((v) => v['db'] == product['price_type'])]
                : null;
        currency =
            currencyList.indexWhere((v) => v == product['currency']) != -1
                ? product['currency']
                : null;
        warranty =
            warrantyList.indexWhere((v) => v == product['warranty']) != -1
                ? product['warranty']
                : null;
        type = typeList.indexWhere((v) => v == product['type']) != -1
            ? product['type']
            : null;
        //main country select
        List l = product['ad_country']['main'];
        if (l.isNotEmpty) {
          selectedMainCountry =
              countries.indexWhere((country) => country["name"] == l[0]) != -1
                  ? countries[countries
                      .indexWhere((country) => country["name"] == l[0])]
                  : null;
        }
        //sub country select
        List pruductSubCountry = product['ad_country']['sub'];

        List subCountries = selectedMainCountry?['children'] ?? [];
        if (pruductSubCountry.isNotEmpty) {
          selectedSubCountry = subCountries.indexWhere(
                      (country) => country["name"] == pruductSubCountry[0]) !=
                  -1
              ? subCountries[subCountries.indexWhere(
                  (country) => country["name"] == pruductSubCountry[0])]
              : null;
        }

        // //sub country select
        List pruductSubCategories = product['ad_cats']['sub'];
        //print("----------------------------" + pruductSubCategories.toString());
        if (pruductSubCategories.isNotEmpty) {
          for (Map<String, dynamic> main in categories) {
            List subCategories = main['children'];
            selectedSubCategory = subCategories.indexWhere(
                        (c) => c["id"] == pruductSubCategories[0]) !=
                    -1
                ? subCategories[subCategories
                    .indexWhere((c) => c["id"] == pruductSubCategories[0])]
                : null;
            if (selectedSubCategory != null) {
              selectedMainCategory = main;
              break;
            }
          }
        }
        List cat = product['ad_cats']['main'];
        if (cat.isNotEmpty) {
          selectedMainCategory =
              categories.indexWhere((c) => c["id"] == cat[0]) != -1
                  ? categories[categories.indexWhere((c) => c["id"] == cat[0])]
                  : null;
        }

        // //main country select

        // print("----------------------------" + cat.toString());
        if (selectedMainCategory!['name'] == 'توصیل' ||
            selectedMainCategory!['name'] == 'خدمات' ||
            selectedMainCategory!['name'] == 'طبي' ||
            selectedMainCategory!['name'] == 'مھن واعمال حرة') {
          isCatService = true;
        } else {
          isCatService = false;
        }
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  @override
  getLists() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(AppLink.cats10ads, {}, '', 'GET');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['statusCode'] == 200) {
        categories.addAll(response['body']['ad_cats']);
        countries.addAll(response['body']['ad_country']);
        conditionListMap.addAll(response['body']['ad_condition']);
        for (var v in conditionListMap) {
          conditionList.add(v['name']);
        }
        warrantyListMap.addAll(response['body']['ad_warranty']);
        for (var v in warrantyListMap) {
          warrantyList.add(v['name']);
        }
        typeListMap.addAll(response['body']['ad_type']);
        for (var v in typeListMap) {
          typeList.add(v['name']);
        }
        currencyListMap.addAll(response['body']['ad_currency']);
        for (var v in currencyListMap) {
          currencyList.add(v['name']);
        }
      } else {
        snack("error".tr, "Server error".tr, Icons.error, 'info');
      }
    }
    update();
  }
}
