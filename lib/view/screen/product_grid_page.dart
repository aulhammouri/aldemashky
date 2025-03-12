import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controller/product_grid_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/class/statusrequest.dart';
import '../wedgets/categories_list.dart';
import '../wedgets/home_header.dart';
import '../wedgets/product_grid.dart';

class ProductGridPage extends StatelessWidget {
  final ProductGridControllerImp controller =
      Get.put(ProductGridControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("main"),
      ),
      body: Column(
        children: [
          HomeHeader(),
          //categories taps
          CategoriesList(),
          //grid
          Expanded(
            child: GetBuilder<ProductGridControllerImp>(
              builder: (controller) {
                return Container(
                    //child: ProductGrid());
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
