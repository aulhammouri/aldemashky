import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_grid_controller.dart';

class Order extends StatelessWidget {
  Order({super.key});
  ProductGridControllerImp controller = Get.put(ProductGridControllerImp());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductGridControllerImp>(
      builder: (controller) => Container(
        padding: EdgeInsets.all(12),
        //color: Colors.white,
        child: Column(
          children: [
            ListTile(
              title: Text("عرض الأحدث أولا"),
              tileColor:
                  controller.orderby == "date" && controller.order == "desc"
                      ? Colors.green.shade100
                      : Colors.grey[50],
              onTap: () {
                controller.orderby = "date";
                controller.order = "desc";
                controller.ads = [];
                controller.getAds(controller.categoryId, 1);

                controller.update();
                Get.back();
              },
            ),
            SizedBox(height: 4),
            ListTile(
              title: Text("عرض الاقدم أولا"),
              tileColor:
                  controller.orderby == "date" && controller.order == "asc"
                      ? Colors.green.shade100
                      : Colors.grey[50],
              onTap: () {
                controller.orderby = "date";
                controller.order = "asc";
                controller.ads = [];
                controller.getAds(controller.categoryId, 1);

                controller.update();
                Get.back();
              },
            ),
            SizedBox(height: 4),
            ListTile(
              title: Text("عرض الأقل سعرا أولا أولا"),
              tileColor:
                  controller.orderby == "price" && controller.order == "asc"
                      ? Colors.green.shade100
                      : Colors.grey[50],
              onTap: () {
                controller.orderby = "price";
                controller.order = "asc";
                controller.ads = [];
                controller.getAds(controller.categoryId, 1);

                controller.update();
                Get.back();
              },
            ),
            SizedBox(height: 4),
            ListTile(
              title: Text("عرض الأعلى سعرا أولا أولا"),
              tileColor:
                  controller.orderby == "price" && controller.order == "desc"
                      ? Colors.green.shade100
                      : Colors.grey[50],
              onTap: () {
                controller.orderby = "price";
                controller.order = "desc";
                controller.ads = [];
                controller.getAds(controller.categoryId, 1);
                controller.update();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
