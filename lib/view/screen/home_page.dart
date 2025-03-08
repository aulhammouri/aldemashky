import 'package:ecommercecourse/controller/hom_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  HomPageControllerImp controller = Get.put(HomPageControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(child: Text(controller.isLogedIn.toString())),
          Center(child: Text(controller.user_email!))
        ],
      ),
    );
  }
}
