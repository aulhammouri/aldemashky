import 'dart:io';

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

abstract class AddProductController extends GetxController {
  addProduct();
  getLists();
  addImageToProduct();
  updateSubCategories(Map<String, dynamic> category);
  updateCondition(String value);
  updateWarranty(String value);
  updateType(String value);
  updatePricType(Map<String, String> priceType);
  updateCurrency(String value);
  updateSubCountries(Map<String, dynamic> Country);
}

class AddProductControllerImp extends AddProductController {
  MyServices myservice = Get.find();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? token;
  String? poster_name;

  final ImagePicker _picker = ImagePicker();
  File? file;
  late TextEditingController category;
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
  void onInit() {
    token = myservice.sharedPreferences.getString('token');
    poster_name = myservice.sharedPreferences.getString('user_nicename');

    category = TextEditingController();
    poster_contact = TextEditingController();
    title = TextEditingController();
    description = TextEditingController();
    price = TextEditingController();
    bidding_date = TextEditingController();
    tagInput = TextEditingController();
    location = TextEditingController();
    getLists();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  addProduct() async {
    var addProductGlobalKey = formState.currentState;
    if (addProductGlobalKey!.validate()) {
      if (!approveConditionStatus) {
        snack("Info", "You have to aprove termes of conditions", Icons.info,
            "info");
        return;
      }
      if (file == null) {
        snack("Error".tr, "You have to upload image".tr, Icons.error, "danger");
        return;
      }
      statusRequest = StatusRequest.loading;
      update();
      var response = await data.requestMultipartData(
          AppLink.addproduct,
          {
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
          file!,
          token,
          'POST');
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['statusCode'] == 200) {
          snack("Done".tr, response['body']['message'], Icons.check, 'success');
          Get.offNamed(AppRoutes.productdetail,
              arguments: response['body']['post_id']);
        } else if (response['statusCode'] == 403) {
          snack("Inputs error".tr, response['body']['message'], Icons.error,
              'info');
        }
        update();
      }

////////////////////////
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

  @override
  addImageToProduct() {
    // TODO: implement addImageToProduct
    throw UnimplementedError();
  }

  List<dynamic> categories = [];

  Map<String, dynamic>? selectedMainCategory;
  Map<String, dynamic>? selectedSubCategory;

  @override
  void updateSubCategories(Map<String, dynamic> category) {
    selectedMainCategory = category;
    selectedSubCategory = null;
    update();
    print(selectedMainCategory);
    print(selectedSubCategory);
  }

  final List<dynamic> countries = [];

  Map<String, dynamic>? selectedMainCountry;
  Map<String, dynamic>? selectedSubCountry;

  @override
  void updateSubCountries(Map<String, dynamic> Country) {
    selectedMainCountry = Country;
    selectedSubCountry = null;
    update();
    print(selectedMainCountry);
    print(selectedSubCountry);
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
  List<String> warrantyList = [];
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
      "db": "Free",
      "viewed": "مجاني",
    },
  ];
  @override
  updatePricType(Map<String, String> value) {
    priceType = value;
    update();
  }

  String? currency;
  final List<dynamic> currencyListMap = [];
  final List<String> currencyList = [];
  @override
  void updateCurrency(String value) {
    currency = value;
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
  getLists() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.requestData(AppLink.catswithsubs, {}, '', 'GET');
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
