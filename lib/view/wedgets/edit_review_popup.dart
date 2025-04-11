import 'package:ecommercecourse/controller/products_manging_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditReviewPopup extends StatelessWidget {
  final ProductsMangingControllerImp controller =
      Get.put(ProductsMangingControllerImp());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تعديل تقييم'),
      content: GetBuilder<ProductsMangingControllerImp>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // حقل التعليق
              TextFormField(
                initialValue: controller.commentEdit,
                onChanged: (value) => controller.updateCommentText(value),
                decoration: const InputDecoration(
                  labelText: 'عدل تعليقك',
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
                      index < controller.ratingEdit!
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
            controller.updateComment();
            //Get.toNamed(AppRoutes.productdetail, arguments: productId);
            Get.back();
          },
          child: const Text('إرسال'),
        ),
      ],
    );
  }
}
