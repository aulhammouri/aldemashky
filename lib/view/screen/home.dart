import 'package:ecommercecourse/controller/home_controller.dart';
import 'package:ecommercecourse/view/wedgets/home_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Text("Newest Ads".tr,
                  style: Theme.of(context).textTheme.headlineMedium),
              HomeList(adsList: homeController.newestAds),
              SizedBox(height: 10),
              Text("Most Viewed".tr,
                  style: Theme.of(context).textTheme.headlineMedium),
              HomeList(adsList: homeController.mostViewedAds),
              SizedBox(height: 10),
              Text("Cheapest Ads".tr,
                  style: Theme.of(context).textTheme.headlineMedium),
              HomeList(adsList: homeController.cheapestAds),
              SizedBox(height: 10),
              Text("Featured Ads".tr,
                  style: Theme.of(context).textTheme.headlineMedium),
              HomeList(adsList: homeController.featuredAds),
            ],
          ),
        ),
      ),
    );
  }
}
