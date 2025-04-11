import 'package:ecommercecourse/controller/product_grid_controller.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/view/screen/aboutus.dart';
import 'package:ecommercecourse/view/screen/auth/login_screen.dart';
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
  int catId = 0;
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
  List<Widget> get listPage => [
        Home(),
        ProductGridPage(),
        isLogedIn == true ? ProductsManging() : LoginScreen(),
        AboutUs(),
      ];

  ProductGridControllerImp productGridControllerImp =
      Get.put(ProductGridControllerImp());
  @override
  changePage(int i, [catId = 0]) {
    currentpage = i;
    if (i == 1 && catId != 0) {
      var _index = productGridControllerImp.categories
          .indexWhere((cat) => cat['id'] == catId);
      productGridControllerImp.selected_cat = _index;
      productGridControllerImp.selected_sub_cat = -1;
      productGridControllerImp.getSubCategories(_index);
      productGridControllerImp.ads = [];
      productGridControllerImp.getAds(catId ?? 0, 1);
    }

    update();
  }
}
