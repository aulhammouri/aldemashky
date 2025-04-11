import 'package:ecommercecourse/controller/add_product_controller.dart';
import 'package:ecommercecourse/controller/signup_controller.dart';
import 'package:ecommercecourse/core/constant/colors.dart';
import 'package:ecommercecourse/core/functions/snack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/valid_input.dart';
import '../../core/class/handlingdataview.dart';
import '../wedgets/custom_btn_widget.dart';
import '../wedgets/custom_input_text_widget.dart';
import '../wedgets/tags_view.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddProductControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primary,
        //title: Text("Create add".tr),
        elevation: 1,
      ),
      body: GetBuilder<AddProductControllerImp>(
        builder: (controller) {
          return Container(
              child: HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: GetBuilder<AddProductControllerImp>(
              builder: (controller) => SingleChildScrollView(
                child: Form(
                  key: controller.formState,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Create add".tr,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'create add screan body'.tr,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(height: 20),
                            DropdownButtonFormField<Map<String, dynamic>>(
                              decoration: InputDecoration(
                                labelText: "chose Main Category".tr,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              value: controller.selectedMainCategory,
                              items: controller.categories.map((category) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: category,
                                  child: Text(category["name"]),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.updateSubCategories(value);
                                }
                              },
                              validator: (val) =>
                                  val == null ? "can't be Empty".tr : null,
                            ),
                            SizedBox(height: 20),
                            controller.selectedMainCategory == null ||
                                    (controller.selectedMainCategory![
                                            'children'] as List)
                                        .isEmpty
                                ? SizedBox()
                                : DropdownButtonFormField<Map<String, dynamic>>(
                                    decoration: InputDecoration(
                                      labelText: "chose sub category".tr,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    value: controller.selectedSubCategory,
                                    items: (controller.selectedMainCategory![
                                            'children'] as List)
                                        .map<
                                                DropdownMenuItem<
                                                    Map<String, dynamic>>>(
                                            (subCategory) {
                                      return DropdownMenuItem<
                                          Map<String, dynamic>>(
                                        value: subCategory,
                                        child: Text(subCategory["name"]),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.selectedSubCategory = value;
                                      controller.update(); // تحديث GetX
                                      print(controller.selectedSubCategory);
                                    },
                                  ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: controller.title,
                              validator: (val) => validInput(val!, 8, 33, ''),
                              decoration: InputDecoration(
                                labelText: "product/serviece name".tr,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            SizedBox(height: 10),
                            /////
                            Container(
                              height: 150,
                              child: TextFormField(
                                controller: controller.description,
                                validator: (val) =>
                                    validInput(val!, 15, 10000, ''),
                                keyboardType: TextInputType.multiline,
                                minLines: 5,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "add more details here...".tr,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            controller.isCatService == false
                                ? Column(
                                    children: [
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: "chose condition".tr,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        value: controller.condition,
                                        items: controller.conditionList
                                            .map((condition) {
                                          return DropdownMenuItem<String>(
                                            value: condition,
                                            child: Text(condition),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.updateCondition(value!);
                                          print(controller.condition);
                                        },
                                        validator: (val) => val == null
                                            ? "can't be Empty".tr
                                            : null,
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: "chose warranty".tr,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        value: controller.warranty,
                                        items: controller.warrantyList
                                            .map((warranty) {
                                          return DropdownMenuItem<String>(
                                            value: warranty,
                                            child: Text(warranty),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.updateWarranty(value!);
                                          print(controller.warranty);
                                        },
                                        validator: (val) => val == null
                                            ? "can't be Empty".tr
                                            : null,
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: "chose ad type".tr,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        value: controller.type,
                                        items: controller.typeList.map((type) {
                                          return DropdownMenuItem<String>(
                                            value: type,
                                            child: Text(type),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.updateType(value!);
                                          print(controller.type);
                                        },
                                        validator: (val) => val == null
                                            ? "can't be Empty".tr
                                            : null,
                                      ),
                                      SizedBox(height: 40),
                                    ],
                                  )
                                : SizedBox(height: 0),

                            DropdownButtonFormField<Map<String, String>>(
                              decoration: InputDecoration(
                                labelText: "chose pricing type".tr,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              value: controller.priceType,
                              items: controller.priceTypeList.map((priceType) {
                                return DropdownMenuItem<Map<String, String>>(
                                  value: priceType,
                                  child: Text(priceType["viewed"]!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.updatePricType(value);
                                  print(controller.priceType?['db']);
                                }
                              },
                              validator: (val) =>
                                  val == null ? "can't be Empty".tr : null,
                            ),
                            SizedBox(height: 10),
                            controller.priceType?['db'] == "Fixed" ||
                                    controller.priceType?['db'] ==
                                        "Negotiable" ||
                                    controller.priceType?['db'] == "auction"
                                ? Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: TextFormField(
                                          controller: controller.price,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                            labelText: "price".tr,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          validator: (val) =>
                                              validInput(val!, 1, 33, 'price'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: "currency".tr,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          value: controller.currency,
                                          items: controller.currencyList
                                              .map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.updateCurrency(value!);
                                            print(controller.type);
                                          },
                                          validator: (val) => val == null
                                              ? "can't be Empty".tr
                                              : null,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(height: 0),
                            SizedBox(height: 10),
                            controller.priceType?['db'] == "auction"
                                ? TextFormField(
                                    controller: controller.bidding_date,
                                    validator: (val) =>
                                        val == "" ? "can't be Empty".tr : null,
                                    decoration: InputDecoration(
                                      labelText: "chose auction final date".tr,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      suffixIcon: Icon(Icons.calendar_today),
                                    ),
                                    onTap: () =>
                                        controller.selectDateTime(context),
                                  )
                                : SizedBox(height: 0),
                            SizedBox(height: 20),
                            TextFormField(
                                controller: controller.tagInput,
                                decoration: InputDecoration(
                                  labelText: "add tags".tr,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller
                                          .addTag(controller.tagInput.text);
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                )),

                            controller.tags.isNotEmpty
                                ? SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.tags.length,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: InkWell(
                                            onTap: () {
                                              controller.removeTag(
                                                  controller.tags[index]);
                                            },
                                            child: Chip(
                                              label:
                                                  Text(controller.tags[index]),
                                              backgroundColor:
                                                  Colors.blue.shade100,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox(height: 5),
                            SizedBox(height: 40),
                            Text("author information".tr),
                            SizedBox(height: 10),
                            ///////country
                            DropdownButtonFormField<Map<String, dynamic>>(
                              decoration: InputDecoration(
                                labelText: "Country".tr,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              value: controller.selectedMainCountry,
                              items: controller.countries.map((c) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: c,
                                  child: Text(c["name"]),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.updateSubCountries(value);
                                }
                              },
                              validator: (val) =>
                                  val == null ? "can't be Empty".tr : null,
                            ),
                            SizedBox(height: 20),
                            controller.selectedMainCountry == null ||
                                    (controller.selectedMainCountry!['children']
                                            as List)
                                        .isEmpty
                                ? SizedBox()
                                : DropdownButtonFormField<Map<String, dynamic>>(
                                    decoration: InputDecoration(
                                      labelText: "City".tr,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    value: controller.selectedSubCountry,
                                    items: (controller.selectedMainCountry![
                                            'children'] as List)
                                        .map<
                                            DropdownMenuItem<
                                                Map<String, dynamic>>>((sc) {
                                      return DropdownMenuItem<
                                          Map<String, dynamic>>(
                                        value: sc,
                                        child: Text(sc["name"]),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.selectedSubCountry = value;
                                      controller.update(); // تحديث GetX
                                      print(controller.selectedSubCountry);
                                    },
                                  ),
                            SizedBox(height: 10),
                            TextFormField(
                                controller: controller.location,
                                validator: (val) =>
                                    validInput(val!, 4, 100, ''),
                                decoration: InputDecoration(
                                  labelText: "address".tr,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                )),
                            SizedBox(height: 10),

                            TextFormField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                                validator: (val) =>
                                    validInput(val!, 8, 33, 'phone'),
                                controller: controller.poster_contact,
                                decoration: InputDecoration(
                                  labelText: "author phone number".tr,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                )),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: controller.choseImage,
                              child: Text("chose image from galery".tr),
                            ),
                            controller.file != null
                                ? Container(
                                    height: 200,
                                    child: Image.file(controller.file!))
                                : SizedBox(height: 5),

                            SizedBox(height: 20),
                            Row(
                              children: [
                                Checkbox(
                                  value: controller.approveConditionStatus,
                                  onChanged: (value) =>
                                      controller.approveCondition(value!),
                                ),
                                Text("I am agree this ".tr),
                                TextButton(
                                  onPressed: () {},
                                  child: Text('conditions'.tr,
                                      style: TextStyle(color: Colors.green)),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: CustomBtnWidget(
                                text: "Publish".tr,
                                onPressed: () {
                                  controller.addProduct();
                                },
                                isLoading: controller.statusRequest ==
                                        StatusRequest.loading
                                    ? true
                                    : false,
                              ),
                            ),

                            SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
