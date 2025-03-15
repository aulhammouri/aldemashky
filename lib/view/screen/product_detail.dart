//import 'package:ecommercecourse/view/wedgets/product/image_viewer.dart';
import 'package:chewie/chewie.dart';
import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:ecommercecourse/view/screen/auth/login_screen.dart';
import 'package:ecommercecourse/view/screen/test_product.dart';
import 'package:ecommercecourse/view/wedgets/product/rating_tag.dart';
import 'package:ecommercecourse/view/wedgets/product/review_tile.dart';
import 'package:ecommercecourse/view/wedgets/product/view_vedio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/product_detail_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../wedgets/custom_btn_widget.dart';
import '../wedgets/product/image_viewer.dart';
import 'auth/login_screan_small.dart';

import 'package:video_player/video_player.dart';

class ProductDetail extends StatelessWidget {
  //final Map product;
  //ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailControllerImp());
    PageController productImageSlider = PageController();
    //Product product = widget.product;
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: ColorApp.p_border, width: 1),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    print("تم النقر على أيقونة واتساب!");
                  },
                  borderRadius:
                      BorderRadius.circular(10), // تأثير دائري عند الضغط
                  child: SvgPicture.asset(ImageAssets.whatsapp),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    print("تم النقر على أيقونة واتساب!");
                  },
                  borderRadius:
                      BorderRadius.circular(10), // تأثير دائري عند الضغط
                  child: SvgPicture.asset(ImageAssets.calling),
                ),
              ),
              Expanded(
                child: Container(
                  height: 64,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: CustomBtnWidget(
                    text: "Add review".tr,
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          height: Get.height * 0.4,
                          child: LoginScreenSmall(),
                        ),
                        isScrollControlled: true,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<ProductDetailControllerImp>(
            builder: (controller) => Container(
                  child: Container(
                    child: HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          // Section 1 - appbar & product image
                          controller.attachmentsCount > 0
                              ? Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    // product image
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ImageViewer(
                                                attachments: controller
                                                    .product['attachments']),
                                            //ImageViewer(imageUrl: product.image),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 310,
                                        color: Colors.white,
                                        child: PageView(
                                          physics: BouncingScrollPhysics(),
                                          controller: productImageSlider,
                                          children: List.generate(
                                            controller
                                                .product['attachments'].length,
                                            (index) => Image.network(
                                              controller.product['attachments']
                                                  [index]['url'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 16,
                                      child: SmoothPageIndicator(
                                        controller: productImageSlider,
                                        count: controller
                                            .product['attachments'].length,
                                        effect: ExpandingDotsEffect(
                                          dotColor: const Color.fromRGBO(
                                              92, 91, 91, 0.4),
                                          activeDotColor: const Color.fromRGBO(
                                              92, 91, 91, 1),
                                          dotHeight: 8,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 5,
                                ),
                          // Section 2 - product info
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.product['title'] ??
                                              'no title',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'poppins',
                                              color: ColorApp.p_secondary),
                                        ),
                                      ),
                                      RatingTag(
                                        margin: EdgeInsets.only(left: 10),
                                        value:
                                            controller.product['rating'] != null
                                                ? controller.product['rating']
                                                    .toDouble()
                                                : 0,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 14),
                                  child: Text(
                                    controller.product['price'].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'poppins',
                                        color: ColorApp.p_primary),
                                  ),
                                ),
                                Html(
                                  data: controller.product['content'] ?? "",
                                ),
                              ],
                            ),
                          ),

                          // Section 2.1 - product vedio
                          controller.haveVideo
                              ? GetBuilder<ProductDetailControllerImp>(
                                  builder: (controller) => Container(
                                        height: 200,
                                        child: ViewVedio(),
                                      ))
                              : GetBuilder<ProductDetailControllerImp>(
                                  builder: (controller) => SizedBox(
                                        height: 5,
                                      )),

                          SizedBox(
                            height: 5,
                          ),
                          // Section 5 - Reviews
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ExpansionTile(
                                  initiallyExpanded: true,
                                  childrenPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 0),
                                  tilePadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  title: Text(
                                    'Reviews'.tr,
                                    style: TextStyle(
                                      color: ColorApp.p_secondary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: controller.commentsCount > 0
                                          ? ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  ReviewTile(
                                                      review: controller
                                                              .product[
                                                          'comments'][index]),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 16),
                                              itemCount: controller
                                                  .product['comments'].length,
                                            )
                                          : Center(child: Text("No Reviews")),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 52, top: 12, bottom: 6),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (context) => ReviewsPage(
                                          //       reviews: product.reviews,
                                          //     ),
                                          // ),
                                          // );
                                        },
                                        child: Text(
                                          'See More Reviews',
                                          style: TextStyle(
                                              color: ColorApp.p_secondary,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: ColorApp.p_primary,
                                          elevation: 0,
                                          backgroundColor:
                                              ColorApp.p_primarySoft,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
