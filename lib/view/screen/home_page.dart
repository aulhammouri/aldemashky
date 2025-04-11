import 'package:ecommercecourse/controller/hom_page_controller.dart';
import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_grid_controller.dart';
import '../../core/constant/colors.dart';
import '../order.dart';
import '../wedgets/home/custombottomappbarhome.dart';
import 'filter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  ProductGridControllerImp productGridControllerImp =
      Get.put(ProductGridControllerImp());

  @override
  Widget build(BuildContext context) {
    Get.put(HomPageControllerImp());
    return GetBuilder<HomPageControllerImp>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: ColorApp.primary,
                title: SizedBox(
                  height: 40,
                  child: TextField(
                    onTap: () {
                      // Get.bottomSheet(
                      //     isScrollControlled: true,
                      //     Container(height: Get.height * 0.9, child: Filter()));
                    },
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: "بحث...",
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: IconButton(
                        icon:
                            Icon(Icons.search, color: Colors.white), // زر البحث
                        onPressed: () {
                          // Get.bottomSheet(
                          //     isScrollControlled: true,
                          //     Container(
                          //         height: Get.height * 0.9, child: Filter()));

                          String query = controller.searchController.text;
                          if (query.isNotEmpty) {
                            productGridControllerImp.searchWorld?.text = query;
                            productGridControllerImp.ads = [];
                            productGridControllerImp.categoryId = 0;
                            productGridControllerImp.selected_cat = -1;
                            productGridControllerImp.subCategories = [];
                            productGridControllerImp.selected_sub_cat = -1;
                            productGridControllerImp.getAds(
                                productGridControllerImp.categoryId, 1);
                            controller.currentpage = 1;
                            controller.update();
                          }
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white), // لون النص
                  ),
                ),
                elevation: 1,
                actions: [
                  IconButton(
                    icon: Icon(Icons.filter_alt),
                    onPressed: () {
                      print("filter");
                      controller.currentpage = 1;
                      controller.update();
                      Get.bottomSheet(
                          isScrollControlled: true,
                          Container(height: Get.height * 0.9, child: Filter()));
                    },
                  ),
                  controller.currentpage == 1
                      ? IconButton(
                          icon: Icon(Icons.swap_vert),
                          onPressed: () {
                            Get.bottomSheet(
                                isScrollControlled: true,
                                Container(
                                    height: Get.height * 0.4, child: Order()));

                            print("order");
                          },
                        )
                      : SizedBox(width: 0),
                  controller.currentpage == 0
                      ? IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () {},
                        )
                      : SizedBox(width: 0),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    controller.isLogedIn == true
                        ? Get.toNamed(AppRoutes.addproduct)
                        : Get.toNamed(AppRoutes.login);
                  },
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add)),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar:
                  SizedBox(height: 70, child: CustomBottomAppBarHome()),
              body: controller.listPage.elementAt(controller.currentpage),
            ));
  }
}
