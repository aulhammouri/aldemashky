import 'package:ecommercecourse/controller/hom_page_controller.dart';
import 'package:ecommercecourse/data/model/category_ads_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/category_ads_controller.dart';
import '../wedgets/categories_list.dart';
import '../wedgets/catrgory_ads_list.dart';
import '../wedgets/home_header.dart';

class CategoryAds extends StatelessWidget {
  const CategoryAds({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryAdsControllerImp controller = Get.put(CategoryAdsControllerImp());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              HomeHeader(),
              CategoriesList(),
              CatrgoryAdsList(),
            ],
          ),
        ),
      ),
    );
  }
}
