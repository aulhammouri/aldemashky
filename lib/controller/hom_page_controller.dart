import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/view/screen/home.dart';
import 'package:ecommercecourse/view/wedgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/screen/product_grid_page.dart';
import '../view/screen/products_manging.dart';

abstract class HomPageController extends GetxController {
  changePage(int i);
}

class HomPageControllerImp extends HomPageController {
  MyServices myServices = Get.find();
  late String? user_email;
  bool? isLogedIn;

  int currentpage = 0;
  late TextEditingController searchController;

  @override
  void onInit() {
    searchController = TextEditingController();

    user_email = myServices.sharedPreferences.getString("user_email");
    isLogedIn = myServices.sharedPreferences.getBool("isLogedIn");
    update();
    super.onInit();
  }

  List titlebottomappbar = [
    "home".tr,
    "categories".tr,
    "profile".tr,
    "about".tr
  ];
  List<Widget> listPage = [
    Home(),
    ProductGridPage(),
    ProductsManging(),
    ProductsManging(),
  ];
  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
