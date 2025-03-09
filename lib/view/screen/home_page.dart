import 'package:ecommercecourse/controller/hom_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wedgets/discount_banner.dart';
import '../wedgets/home_header.dart';
import '../wedgets/popular_products.dart';
import '../wedgets/recently_added_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomPageControllerImp controller = Get.put(HomPageControllerImp());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              HomeHeader(),
              DiscountBanner(),
              PopularProducts(),
              SizedBox(height: 20),
              RecentlyAddedProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
