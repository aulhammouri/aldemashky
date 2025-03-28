import 'package:ecommercecourse/controller/about_us_controller.dart';
import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutusCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> said;
  AboutusCarousel({super.key, required this.said});

  AboutUsControllerImp controller = Get.put(AboutUsControllerImp());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GetBuilder<AboutUsControllerImp>(
          builder: (controller) => Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: PageView.builder(
              controller: controller.pageController1,
              itemCount: said.length,
              physics: BouncingScrollPhysics(), // حركة سلسة
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      ImageAssets.circlebg,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high, // تحسين الجودة
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.person,
                                size: 40, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 10),
                          Text(
                            said[index]['name'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            said[index]['nickname'],
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              said[index]['body'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                5,
                                (index) => Icon(Icons.star,
                                    color: Colors.amber, size: 20)),
                          ),
                        ],
                      ),
                    )
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
