import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/review_controller.dart';

class ReviewPopup extends StatelessWidget {
  final int productId;

  ReviewPopup({required this.productId});

  final ReviewController controller = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إضافة تقييم'),
      content: GetBuilder<ReviewController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // حقل التعليق
              TextField(
                onChanged: (value) => controller.updateComment(value),
                decoration: const InputDecoration(
                  labelText: 'أضف تعليقك',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // تقييم النجوم
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < controller.rating
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () => controller.updateRating(index + 1),
                  );
                }),
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('إلغاء'),
        ),
        TextButton(
          onPressed: () {
            controller.submitReview(productId);
            //Get.toNamed(AppRoutes.productdetail, arguments: productId);
            Get.back();
          },
          child: const Text('إرسال'),
        ),
      ],
    );
  }
}
