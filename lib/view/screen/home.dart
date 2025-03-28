import 'package:ecommercecourse/controller/home_controller.dart';
import 'package:ecommercecourse/core/class/statusrequest.dart';
import 'package:ecommercecourse/view/wedgets/home_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wedgets/category_card.dart';
import '../wedgets/home/home_list_loading.dart';
import '../wedgets/home/image_carousel.dart';

class Home extends StatelessWidget {
  Home({super.key});

  HomeControllerImp homeController = Get.put(HomeControllerImp());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImp>(
      builder: (controller) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCarousel(),
              SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Text("categories".tr,
              //       style: Theme.of(context).textTheme.headlineMedium),
              // ),
              SizedBox(
                  height: 80,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.categories.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                            category: homeController.categories[index]);
                      })),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Newest Ads".tr,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              controller.statusRequest == StatusRequest.loading
                  ? HomeListLoading()
                  : HomeList(
                      adsList: homeController.newestAds,
                      type: 'newest',
                    ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Most Viewed".tr,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              controller.statusRequest == StatusRequest.loading
                  ? HomeListLoading()
                  : HomeList(
                      adsList: homeController.mostViewedAds,
                      type: 'mostviewed',
                    ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Cheapest Ads".tr,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              controller.statusRequest == StatusRequest.loading
                  ? HomeListLoading()
                  : HomeList(
                      adsList: homeController.cheapestAds,
                      type: 'cheapest',
                    ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Featured Ads".tr,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              controller.statusRequest == StatusRequest.loading
                  ? HomeListLoading()
                  : HomeList(
                      adsList: homeController.featuredAds,
                      type: 'featured',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
