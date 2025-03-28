import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/products_manging_controller.dart';
import '../../core/class/statusrequest.dart';
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
                  SizedBox(height: 40),
                  Text("hi".tr + controller.userNicename!),
                  SizedBox(height: 20),
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
                              color: Colors.green,
                            ),
                            SizedBox(height: 10),
                            controller.adscount['sold'] == null
                                ? CircularProgressIndicator()
                                : Text(
                                    controller.adscount['active'].toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
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
                              color: Colors.orange,
                            ),
                            SizedBox(height: 10),
                            controller.adscount['sold'] == null
                                ? CircularProgressIndicator()
                                : Text(
                                    controller.adscount['sold'].toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                            SizedBox(height: 5),
                            Text(
                              controller.statics[1]['title'],
                              style: TextStyle(
                                color: Colors.orange,
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
                              color: Colors.blue,
                            ),
                            SizedBox(height: 10),
                            controller.adscount['sold'] == null
                                ? CircularProgressIndicator()
                                : Text(
                                    controller.adscount['expired'].toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                            SizedBox(height: 5),
                            Text(
                              controller.statics[2]['title'],
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      childrenPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                      tilePadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                                    subtitle:
                                        Text(controller.ads[index]['date']),
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
                                                  controller.updateAdStatus(
                                                      controller.ads[index]
                                                          ['id'],
                                                      'active');
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
                                                  controller.updateAdStatus(
                                                      controller.ads[index]
                                                          ['id'],
                                                      'sold');
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
                                                  controller.updateAdStatus(
                                                      controller.ads[index]
                                                          ['id'],
                                                      'expired');
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
                                                  controller.editAd(
                                                      controller.ads[index]
                                                          ['id'],
                                                      index);
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
                                                  controller.deleteAd(
                                                      controller.ads[index]
                                                          ['id'],
                                                      index);
                                                },
                                              ),
                                            ]),
                                    tileColor: controller.ads[index]
                                                ['status'] ==
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
                          // margin: EdgeInsets.only(left: 52, top: 12, bottom: 6),
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
                              child: Row(
                                children: [
                                  Text(
                                    'See More Ads'.tr,
                                    style: TextStyle(
                                        color: ColorApp.headLine1Color,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  controller.statusRequest ==
                                          StatusRequest.loading
                                      ? Center(
                                          child: Lottie.asset(
                                              ImageAssets.dowonloading,
                                              height: 40),
                                        )
                                      : Spacer(),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      childrenPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                      tilePadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                                    title: Text(
                                        controller.comments[index]['title']),
                                    subtitle: Text("ads: ".tr +
                                        controller.comments[index]['product'] +
                                        ", " +
                                        " review: ".tr +
                                        controller.comments[index]
                                            ['review_star'] +
                                        " stars".tr),
                                    tileColor: Colors.grey.shade300,
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
                                                          ['id'],
                                                      index);
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
                                                          ['id'],
                                                      index);
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
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock),
                        SizedBox(width: 10),
                        Text('Update my password'.tr),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.logout_outlined),
                        SizedBox(width: 10),
                        Text('Log Out'.tr),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
