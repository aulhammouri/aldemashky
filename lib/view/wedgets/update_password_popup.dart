import 'package:ecommercecourse/controller/products_manging_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordPopup extends StatelessWidget {
  final ProductsMangingControllerImp controller =
      Get.put(ProductsMangingControllerImp());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تعديل كلمة المرور'),
      content: GetBuilder<ProductsMangingControllerImp>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller.newpassword,
                //initialValue: controller.newpassword!.text,
                onChanged: (value) {
                  controller.newpassword!.text = value;
                  controller.update();
                },
                decoration: const InputDecoration(
                  labelText: 'اكتب كلمة المرور الجديدة',
                  border: OutlineInputBorder(),
                ),
              ),
              controller.newpassword!.text == "" ||
                      controller.newpassword!.text.length < 8
                  ? Text("يجب ان تكون كلمة السر لا تقل عن 8 أحرف",
                      style: TextStyle(color: Colors.red))
                  : SizedBox(height: 15),
              const SizedBox(height: 10),
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
            controller.updatePassword();
            //Get.toNamed(AppRoutes.productdetail, arguments: productId);
            Get.back();
          },
          child: const Text('إرسال'),
        ),
      ],
    );
  }
}
