import 'package:ecommercecourse/controller/category_ads_controller.dart';
import 'package:ecommercecourse/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/category_ads_model.dart';

class CategoriesList extends StatelessWidget {
  //final List categories;
  late CategoryAdsModel cats;

  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryAdsControllerImp>(
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
                            cats.name.toString(),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          controller.selected_cat = index;
                          controller.selected_sub_cat = 0;
                          controller.getSubCategories(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
              height: 40, // ارتفاع القائمة
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
                                    cats.name.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  controller.selected_sub_cat = index;
                                  controller.getAds(index);
                                  //controller.getAds(index);
                                  //controller.getSubCategories(index);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Text("no sub categories")),
        ],
      ),
    );
  }
}
