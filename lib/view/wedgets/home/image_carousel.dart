import 'package:ecommercecourse/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCarousel extends StatelessWidget {
  final HomeControllerImp controller = Get.find<HomeControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GetBuilder<HomeControllerImp>(
          builder: (controller) => Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.images.length,
              physics: BouncingScrollPhysics(), // حركة سلسة
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      controller.images[index]['image'],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high, // تحسين الجودة
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          controller.images[index]['icon'],
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(height: 10),
                        Text(
                          controller.images[index]['number'].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          controller.images[index]['title'],
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
