import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/products_manging_controller.dart';
import '../../core/constant/colors.dart';

class ProductsManging extends StatelessWidget {
  ProductsManging({super.key});
  ProductsMangingControllerImp controller =
      Get.put(ProductsMangingControllerImp());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<ProductsMangingControllerImp>(
              builder: (controller) => Column(
                children: [
                  SizedBox(height: 20),
                  Text("hi".tr + controller.userNicename!),
                  Text("product Managing body".tr),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              controller.statics[0]['icon'],
                              size: 40,
                            ),
                            SizedBox(height: 10),
                            Text(
                              controller.adscount['active'].toString(),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              controller.statics[0]['title'],
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              controller.statics[1]['icon'],
                              size: 40,
                            ),
                            SizedBox(height: 10),
                            Text(
                              controller.adscount['sold'].toString(),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              controller.statics[1]['title'],
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              controller.statics[2]['icon'],
                              size: 40,
                            ),
                            SizedBox(height: 10),
                            Text(
                              controller.adscount['expired'].toString(),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              controller.statics[2]['title'],
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: true,
                    childrenPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    tilePadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    title: Text(
                      'My Ads'.tr,
                    ),
                    collapsedBackgroundColor: Colors.grey.shade200,
                    subtitle: Text("active, sold, expired, edit, delete".tr),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: controller.ads.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => ListTile(
                                  leading: Image.asset(
                                    ImageAssets.carousel0,
                                    width: 80,
                                  ),
                                  title: Text(controller.ads[index]['title']),
                                  subtitle: Text(controller.ads[index]['date']),
                                  trailing: PopupMenuButton(
                                      onSelected: (value) {
                                        print(value);
                                      },
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: "active",
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.green,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Make it Active'.tr,
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.makeAdActive(
                                                    controller.ads[index]
                                                        ['id']);
                                              },
                                            ),
                                            PopupMenuItem(
                                              value: "sold",
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.orange,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Make it Sold'.tr,
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.makeAdSold(controller
                                                    .ads[index]['id']);
                                              },
                                            ),
                                            PopupMenuItem(
                                              value: "expired",
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Make it Expired'.tr,
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.makeAdExpired(
                                                    controller.ads[index]
                                                        ['id']);
                                              },
                                            ),
                                            PopupMenuItem(
                                              value: "edit",
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "Edit".tr,
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.editAd(controller
                                                    .ads[index]['id']);
                                              },
                                            ),
                                            PopupMenuItem(
                                              value: "deleted",
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Delete'.tr,
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.deleteAd(controller
                                                    .ads[index]['id']);
                                              },
                                            ),
                                          ]),
                                  tileColor: controller.ads[index]['status'] ==
                                          "expired"
                                      ? Colors.blue.shade100
                                      : controller.ads[index]['status'] ==
                                              "sold"
                                          ? Colors.orange.shade100
                                          : Colors.green.shade100,
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 4),
                                itemCount: controller.ads.length,
                              )
                            : Center(child: Text("No Ads".tr)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 52, top: 12, bottom: 6),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.getMoreAds();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: ColorApp.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(
                            'See More Ads'.tr,
                            style: TextStyle(
                                color: ColorApp.headLine1Color,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 4),
                  ExpansionTile(
                    initiallyExpanded: true,
                    childrenPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    tilePadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    title: Text('My Comments'.tr),
                    collapsedBackgroundColor: Colors.grey.shade200,
                    subtitle: Text("edit, delete".tr),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: controller.comments.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => ListTile(
                                  leading: Text(index.toString()),
                                  title:
                                      Text(controller.comments[index]['title']),
                                  subtitle: Text("ads: ".tr +
                                      controller.comments[index]['product'] +
                                      ", " +
                                      " review: ".tr +
                                      controller.comments[index]
                                          ['review_star'] +
                                      " stars".tr),
                                  tileColor: Colors.grey.shade100,
                                  trailing: PopupMenuButton(
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: "edit",
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Edit'.tr,
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.editComment(
                                                    controller.comments[index]
                                                        ['id']);
                                              },
                                            ),
                                            PopupMenuItem(
                                              value: "deleted",
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Delete'.tr,
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.deleteComment(
                                                    controller.comments[index]
                                                        ['id']);
                                              },
                                            ),
                                          ]),
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 4),
                                itemCount: controller.comments.length,
                              )
                            : Center(child: Text("No Comments".tr)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 52, top: 12, bottom: 6),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.getMoreAds();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: ColorApp.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(
                            'See More Comments'.tr,
                            style: TextStyle(
                                color: ColorApp.headLine1Color,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 4),
                  ExpansionTile(
                    initiallyExpanded: true,
                    childrenPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    tilePadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    title: Text('Update my password'.tr),
                    collapsedBackgroundColor: Colors.grey.shade200,
                    subtitle: Text("update password"),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                  SizedBox(height: 4),
                  ExpansionTile(
                    initiallyExpanded: true,
                    childrenPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    tilePadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    title: Text('Log Out'.tr),
                    collapsedBackgroundColor: Colors.grey.shade200,
                    subtitle: Text("Log Out"),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
