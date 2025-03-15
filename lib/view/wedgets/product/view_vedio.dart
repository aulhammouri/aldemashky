import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../controller/product_detail_controller.dart';

class ViewVedio extends StatelessWidget {
  ProductDetailControllerImp controller = Get.put(ProductDetailControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProductDetailControllerImp>(
      builder: (controller) => Stack(
        children: [
          Center(
            child: controller.vVcontroller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller.vVcontroller.value.aspectRatio,
                    child: VideoPlayer(controller.vVcontroller),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 5, // المسافة من الأسفل
            right: 25, // المسافة من اليمين
            child: FloatingActionButton.small(
              onPressed: () {
                controller.playPause();
              },
              child: Icon(
                controller.vVcontroller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
