import 'package:ecommercecourse/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_grid_controller.dart';
import '../../data/model/category_ads_model.dart';

// ignore: must_be_immutable
class CategoriesList extends StatelessWidget {
  //final List categories;
  late CategoryAdsModel cats;

  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductGridControllerImp>(
      builder: (controller) => Column(
        children: [
          SizedBox(height: 12),
          SizedBox(
            height: 40, // ارتفاع القائمة
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // تحديد الاتجاه الأفقي
              itemCount: controller.categories.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                cats = CategoryAdsModel.fromJson(controller.categories[index]);
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: controller.selected_cat == index
                                ? Border(
                                    bottom: BorderSide(
                                        color: ColorApp.primary, width: 2))
                                : null, // إضافة الحد السفلي فقط إذا تحقق الشرط
                          ),
                          child: Text(
                            controller.categories[index]['name'],
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          controller.selected_cat = index;
                          controller.selected_sub_cat = -1;
                          controller.getSubCategories(index);
                          controller.ads = [];
                          controller.getAds(
                              controller.categories[index]['id'], 1);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
              height: controller.haveSubCategories == true
                  ? 40
                  : 0, // ارتفاع القائمة
              child: controller.haveSubCategories == true
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal, // تحديد الاتجاه الأفقي
                      itemCount: controller.subCategories.length,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        cats = CategoryAdsModel.fromJson(
                            controller.subCategories[index]);
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: controller.selected_sub_cat == index
                                        ? Border(
                                            bottom: BorderSide(
                                                color: ColorApp.primary,
                                                width: 2))
                                        : null, // إضافة الحد السفلي فقط إذا تحقق الشرط
                                  ),
                                  child: Text(
                                    controller.subCategories[index]['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  controller.selected_sub_cat = index;
                                  controller.ads = [];
                                  controller.getAds(
                                      controller.subCategories[index]['id'], 1);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : null),
        ],
      ),
    );
  }
}
