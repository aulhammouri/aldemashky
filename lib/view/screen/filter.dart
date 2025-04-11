import 'package:ecommercecourse/controller/product_grid_controller.dart';
import 'package:ecommercecourse/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/colors.dart';

class Filter extends StatelessWidget {
  Filter({super.key});
  ProductGridControllerImp controller = Get.put(ProductGridControllerImp());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductGridControllerImp>(
        builder: (controller) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child: Column(
                  children: [
                    // SizedBox(height: 20),
                    // Text("صفحة الفلترة"),
                    SizedBox(height: 20),
                    Container(
                      child: TextFormField(
                        controller: controller.searchWorld,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: Text(" كلمة البحث"),
                          hintText: "أدخل كلمة للبحث",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorApp.textInputBorderColor,
                                width: 1.5),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      color: Colors.white,
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: ListTile(
                                  title: Text("الحالة",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                )),
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("لا يهم"),
                                  value: "",
                                  groupValue: controller.conditionSearch,
                                  onChanged: (value) {
                                    controller.conditionSearch = value;
                                    controller.update();
                                  },
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("جديد"),
                                  value: "جديد",
                                  groupValue: controller.conditionSearch,
                                  onChanged: (value) {
                                    controller.conditionSearch = value;
                                    controller.update();
                                  },
                                )),
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("مستخدم"),
                                  value: "مستخدم",
                                  groupValue: controller.conditionSearch,
                                  onChanged: (value) {
                                    controller.conditionSearch = value;
                                    controller.update();
                                  },
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      color: Colors.white,
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: ListTile(
                                  title: Text("الضمان",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                )),
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("لا يهم"),
                                  value: "",
                                  groupValue: controller.warranty,
                                  onChanged: (value) {
                                    controller.warranty = value;
                                    controller.update();
                                  },
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("نعم"),
                                  value: "نعم",
                                  groupValue: controller.warranty,
                                  onChanged: (value) {
                                    controller.warranty = value;
                                    controller.update();
                                  },
                                )),
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("لا"),
                                  value: "لا",
                                  groupValue: controller.warranty,
                                  onChanged: (value) {
                                    controller.warranty = value;
                                    controller.update();
                                  },
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      color: Colors.white,
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: ListTile(
                                  title: Text("نوع الاعلان",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                )),
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("لا يهم"),
                                  value: "",
                                  groupValue: controller.ad_type,
                                  onChanged: (value) {
                                    controller.ad_type = value;
                                    controller.update();
                                  },
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("بيع"),
                                  value: "بيع",
                                  groupValue: controller.ad_type,
                                  onChanged: (value) {
                                    controller.ad_type = value;
                                    controller.update();
                                  },
                                )),
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("أجار"),
                                  value: "أجار",
                                  groupValue: controller.ad_type,
                                  onChanged: (value) {
                                    controller.ad_type = value;
                                    controller.update();
                                  },
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("تبادل"),
                                  value: "تبادل",
                                  groupValue: controller.ad_type,
                                  onChanged: (value) {
                                    controller.ad_type = value;
                                    controller.update();
                                  },
                                )),
                                Expanded(
                                    child: RadioListTile(
                                  title: Text("شراء"),
                                  value: "شراء",
                                  groupValue: controller.ad_type,
                                  onChanged: (value) {
                                    controller.ad_type = value;
                                    controller.update();
                                  },
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.minPrice,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: Text("أقل سعر"),
                                  //hintText: "من",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: ColorApp.textInputBorderColor,
                                        width: 1.5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: controller.maxPrice,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: Text("أعلى سعر"),
                                  //hintText: "إلى",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: ColorApp.textInputBorderColor,
                                        width: 1.5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.afterdate,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: Text("من تاريخ"),
                                  //hintText: "من",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: ColorApp.textInputBorderColor,
                                        width: 1.5),
                                  ),
                                ),
                                onTap: () => {
                                  controller.selectDateTime(context, "after")
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: controller.beforedate,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: Text("حتى تاريخ"),
                                  //hintText: "إلى",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: ColorApp.textInputBorderColor,
                                        width: 1.5),
                                  ),
                                ),
                                onTap: () => {
                                  controller.selectDateTime(context, "before")
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.searchLocation,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: Text("العنوان"),
                                  hintText: "عنوان البائع",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: ColorApp.textInputBorderColor,
                                        width: 1.5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        controller.ads = [];
                        controller.categoryId = 0;
                        controller.selected_cat = -1;
                        controller.subCategories = [];
                        controller.selected_sub_cat = -1;
                        controller.getAds(controller.categoryId, 1);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorApp.btnBgColor,
                        disabledBackgroundColor: ColorApp.btnDisBgColor,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: controller.statusRequest == StatusRequest.loading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                                //strokeWidth: 2,
                              )
                            : Text("بحث",
                                style: TextStyle(
                                    fontSize: 18, color: ColorApp.btntxtColor)),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
