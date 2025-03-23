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
            height: 60, // ارتفاع القائمة
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // تحديد الاتجاه الأفقي
              itemCount: controller.categories.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                cats = CategoryAdsModel.fromJson(controller.categories[index]);
                final isSelected = controller.selected_cat == index;

                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      InkWell(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorApp.primary
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            controller.categories[index]['name'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
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
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.subCategories.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final subCategory = controller.subCategories[index];
                        final isSelected = controller.selected_sub_cat == index;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              controller.selected_sub_cat = index;
                              controller.ads = [];
                              controller.getAds(subCategory['id'], 1);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorApp.primary
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  subCategory['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
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
