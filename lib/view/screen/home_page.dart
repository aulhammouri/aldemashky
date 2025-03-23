import 'package:ecommercecourse/controller/hom_page_controller.dart';
import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/colors.dart';
import '../wedgets/home/custombottomappbarhome.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomPageControllerImp());
    return GetBuilder<HomPageControllerImp>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: "بحث...",
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: IconButton(
                        icon:
                            Icon(Icons.search, color: Colors.white), // زر البحث
                        onPressed: () {
                          String query = controller.searchController.text;
                          if (query.isNotEmpty) {
                            print("تم البحث عن: $query"); // نفّذ الإجراء هنا
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
                backgroundColor: ColorApp.primary,
                //title: Text("main".tr),
                elevation: 1,
                actions: [
                  IconButton(
                    icon: Icon(Icons.filter_alt),
                    onPressed: () {
                      print("filter");
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.addproduct);
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
