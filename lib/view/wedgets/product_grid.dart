import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:ecommercecourse/view/screen/product_detail.dart';
import 'package:ecommercecourse/view/wedgets/product_card_column.dart';
import 'package:ecommercecourse/view/wedgets/product_card_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_grid_controller.dart';

class ProductGrid extends StatelessWidget {
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
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // 2, // 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3.3, // 0.6, //3,
        ),
        itemCount: controller.ads.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8), // حواف دائرية
              border: Border.all(
                color: Colors.green, // لون الإطار
                width: 1, // سمك الإطار
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26, // ظل خفيف
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            //color: index.isOdd ? Colors.black12 : Colors.white12,
            child: ProductCardRow(
              ads: controller.ads[index],
              onPress: () {
                Get.toNamed(AppRoutes.productdetail,
                    arguments: controller.ads[index]['ID']);
              },
            ),
          );
        },
      ),
    );
  }
}
