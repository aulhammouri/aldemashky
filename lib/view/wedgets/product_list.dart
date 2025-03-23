import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:ecommercecourse/view/wedgets/home_card.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_grid_controller.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductGridControllerImp controller = Get.put(ProductGridControllerImp());

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels >=
                scrollNotification.metrics.maxScrollExtent * 0.9 &&
            !controller.isLoading) {
          controller.adstotalPage > controller.adsCurrentPage
              ? {
                  controller.adsCurrentPage = controller.adsCurrentPage + 1,
                  controller.getAdsFromScroll(
                      controller.categoryId, controller.adsCurrentPage),
                }
              : null;
        }
        return false;
      },
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // جعل القائمة أفقية
        //padding: EdgeInsets.all(10),
        itemCount: controller.ads.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 5), // تباعد بين العناصر
            child: Column(
              children: [
                HomeCard(
                  ads: controller.ads[index],
                  onPress: () {
                    Get.toNamed(AppRoutes.editproduct,
                        arguments: controller.ads[index]['ID']);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
