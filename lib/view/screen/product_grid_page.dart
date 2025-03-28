import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_grid_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../wedgets/categories_list.dart';
import '../wedgets/product_grid.dart';

class ProductGridPage extends StatelessWidget {
  final ProductGridControllerImp controller =
      Get.put(ProductGridControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //HomeHeader(),
          //categories taps
          CategoriesList(),
          //grid
          Expanded(
            child: GetBuilder<ProductGridControllerImp>(
              builder: (controller) {
                return Container(
                    child: HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: ProductGrid(),
                ));
              },
            ),
          ),
          //loading icon
          GetBuilder<ProductGridControllerImp>(
            builder: (controller) {
              return controller.isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
