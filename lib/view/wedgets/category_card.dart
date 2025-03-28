import 'package:ecommercecourse/controller/hom_page_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;

  CategoryCard({super.key, required this.category});

  HomPageControllerImp controller = Get.put(HomPageControllerImp());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomPageControllerImp>(
        builder: (controller) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  controller.changePage(1, category['id']);
                },
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(category['image'], width: 50, height: 50),
                      SizedBox(height: 8),
                      Text(
                        category['cat'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
