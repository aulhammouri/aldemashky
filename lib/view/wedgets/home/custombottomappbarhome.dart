import 'package:ecommercecourse/controller/hom_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custombuttonappbar.dart';

class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomPageControllerImp>(
        builder: (controller) => BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6,
            child: Row(
              children: [
                ...List.generate(controller.listPage.length + 1, ((index) {
                  int i = index > 2 ? index - 1 : index;
                  return index == 2
                      ? Spacer()
                      : CustomButtonAppBar(
                          textbutton: controller.titlebottomappbar[i],
                          icondata: i == 0
                              ? Icons.home
                              : i == 1
                                  ? Icons.category
                                  : i == 2
                                      ? Icons.person
                                      : Icons.apartment_outlined,
                          onPressed: () {
                            controller.changePage(i);
                          },
                          active: controller.currentpage == i ? true : false);
                }))
              ],
            )));
  }
}
