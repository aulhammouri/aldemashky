import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/functions/valid_input.dart';
import '../../controller/edit_product_controller.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/imageassets.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditProductControllerImp());
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit add".tr),
          elevation: 1,
        ),
        body: GetBuilder<EditProductControllerImp>(
          builder: (controller) => SingleChildScrollView(
              child: Stack(
            children: [
              Form(
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
                              "Edit add".tr,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          controller.statusRequest == StatusRequest.loading
                              ? Center(
                                  child: Lottie.asset(ImageAssets.dowonloading,
                                      height: 40),
                                )
                              : SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'edit add screan body'.tr,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(height: 20),
                          DropdownButtonFormField<Map<String, dynamic>>(
                            decoration: InputDecoration(
                              labelText: "Chose Main Category".tr,
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
                          SizedBox(
                            height: 20,
                          ),
                          controller.selectedMainCategory == null ||
                                  (controller.selectedMainCategory!['children']
                                          as List)
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
                                  items: (controller
                                              .selectedMainCategory!['children']
                                          as List)
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
                                    controller.update();
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
                              }
                            },
                            validator: (val) =>
                                val == null ? "can't be Empty".tr : null,
                          ),
                          SizedBox(height: 10),
                          controller.priceType?['db'] == "Fixed" ||
                                  controller.priceType?['db'] == "Negotiable" ||
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
                                    controller.addTag(controller.tagInput.text);
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
                                            label: Text(controller.tags[index]),
                                            backgroundColor:
                                                Colors.blue.shade50,
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
                                controller.updateMainCountry(value);
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
                                  items: (controller
                                              .selectedMainCountry!['children']
                                          as List)
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
                                    controller.updateSubCountry(value!);
                                  },
                                ),
                          SizedBox(height: 10),
                          TextFormField(
                              controller: controller.location,
                              validator: (val) => validInput(val!, 4, 100, ''),
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

                          SizedBox(height: 20),
                          controller.statusRequest == StatusRequest.loading
                              ? Center(
                                  child: Lottie.asset(ImageAssets.dowonloading,
                                      height: 60),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    controller.editProduct();
                                  },
                                  child: Text("Save changing".tr),
                                ),

                          SizedBox(height: 20),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.attachments.length,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Column(
                                    children: [
                                      Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            Image.network(
                                              height: 100,
                                              controller.attachments[index]
                                                  ['url'],
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            (loadingProgress
                                                                    .expectedTotalBytes ??
                                                                1)
                                                        : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                  child: Icon(
                                                      Icons.broken_image,
                                                      size: 50,
                                                      color: Colors.red),
                                                );
                                              },
                                            ),
                                            Positioned(
                                              top: 4,
                                              left: 8,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.removeImage(
                                                      controller
                                                          .attachments[index]);
                                                },
                                                child: Icon(Icons.close,
                                                    color: Colors.red,
                                                    size: 30),
                                              ),
                                            )
                                          ]),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: () {
                              controller.saveOnotherImage();
                            },
                            child: Text("add new image".tr),
                          ),
                          // Section 2.1 - product vedio
                          controller.product['video_url'] == null ||
                                  controller.product['video_url'].isEmpty
                              ? ElevatedButton(
                                  onPressed: () {
                                    controller.saveVedio();
                                  },
                                  child: Text("add video".tr),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    controller.deleteVedio(
                                        controller.product['video_url']);
                                  },
                                  child: Text("delete the video".tr),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
