//import 'package:ecommercecourse/view/wedgets/product/image_viewer.dart';
import 'package:chewie/chewie.dart';
import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:ecommercecourse/view/screen/auth/login_screen.dart';
import 'package:ecommercecourse/view/screen/test_product.dart';
import 'package:ecommercecourse/view/wedgets/product/rating_tag.dart';
import 'package:ecommercecourse/view/wedgets/product/review_tile.dart';
import 'package:ecommercecourse/view/wedgets/product/view_vedio.dart';
import 'package:ecommercecourse/view/wedgets/tags_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/product_detail_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../wedgets/custom_btn_widget.dart';
import '../wedgets/product/image_viewer.dart';
import '../wedgets/product/review_popup.dart';
import 'auth/login_screan_small.dart';

import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductDetail extends StatelessWidget {
  //final Map product;
  //ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductDetailControllerImp());

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
            child: GetBuilder<ProductDetailControllerImp>(
              builder: (controller) => Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        controller.whatsappAuthor(
                            controller.product['poster_contact'],
                            "مرحباُ،\n اراسلك حول الاعلان المنشور بعنوان ${controller.product['title']} \n");
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
                        controller
                            .callAuther(controller.product['poster_contact']);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: SvgPicture.asset(
                        ImageAssets.calling,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: CustomBtnWidget(
                        text: "Add review".tr,
                        onPressed: () {
                          int productId = int.parse(controller.product['id']);
                          Get.dialog(
                            ReviewPopup(productId: productId),
                            arguments: productId,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
        body: GetBuilder<ProductDetailControllerImp>(
            builder: (controller) => HandlingDataView(
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
                                      width: MediaQuery.of(context).size.width,
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
                                                child: Icon(Icons.broken_image,
                                                    size: 50,
                                                    color: Colors.red),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  bottom: 16,
                                  child: SmoothPageIndicator(
                                    controller: productImageSlider,
                                    count: controller
                                        .product['attachments'].length,
                                    effect: ExpandingDotsEffect(
                                      dotColor:
                                          const Color.fromRGBO(92, 91, 91, 0.4),
                                      activeDotColor:
                                          const Color.fromRGBO(92, 91, 91, 1),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      controller.product['title'] ?? 'no title',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'poppins',
                                          color: ColorApp.p_secondary),
                                    ),
                                  ),
                                  RatingTag(
                                    margin: EdgeInsets.only(left: 10),
                                    value: controller.product['rating'] != null
                                        ? controller.product['rating']
                                            .toDouble()
                                        : 0,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  controller.product['price'] ?? "",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'poppins',
                                      color: ColorApp.btnBgColor),
                                ),
                                Text(
                                  " ${controller.product['currency'] ?? '\$'}",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'poppins',
                                      color: ColorApp.btnBgColor),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  controller.product['price_type'] == 'on_call'
                                      ? "On Call".tr
                                      : controller.product['price_type'] ==
                                              'Negotiable'
                                          ? "Negotiable".tr
                                          : controller.product['price_type'] ==
                                                  'Fixed'
                                              ? "Fixed".tr
                                              : controller.product[
                                                          'price_type'] ==
                                                      'auction'
                                                  ? "Auction".tr
                                                  : "Free".tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'poppins',
                                      color: ColorApp.p_accent),
                                ),
                              ],
                            ),
                            Html(
                              data: controller.product['content'] ?? "",
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment:
                                  //    MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 14, color: Colors.black),
                                    const SizedBox(width: 4),
                                    Text(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller.product['location'] ??
                                          "Unknown location",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                if (controller.product['condition'] != null &&
                                    controller.product['condition'] != "")
                                  Text(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    "Status: " +
                                        controller.product['condition'],
                                  ),
                                const SizedBox(height: 4),
                                if (controller.product['warranty'] != null &&
                                    controller.product['warranty'] != "")
                                  Text(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // ignore: prefer_interpolation_to_compose_strings
                                    "Warranty: " +
                                        controller.product['warranty'],
                                  ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.tag,
                                        size: 18, color: Colors.black),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Tags'.tr,
                                      style: TextStyle(
                                        color: ColorApp.p_secondary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                (controller.product['tags'] != null &&
                                        controller.product['tags'] != [])
                                    ? controller.product['tags'].length > 0
                                        ? Container(
                                            child: TagsView(
                                                tags:
                                                    controller.product['tags']),
                                          )
                                        : Text(
                                            "no tags",
                                          )
                                    : SizedBox(
                                        height: 5,
                                      )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.product['published_date'] != null
                                    ? Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.date_range,
                                                  size: 16,
                                                  color: Colors.black),
                                              Text(
                                                timeago.format(
                                                    DateFormat(
                                                            "yyyy-MM-dd HH:mm:ss")
                                                        .parse(controller
                                                                .product[
                                                            'published_date']),
                                                    locale: 'ar'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        height: 5,
                                      ),
                                Row(
                                  children: [
                                    Icon(Icons.visibility,
                                        size: 14, color: Colors.black),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${controller.product['views_count'] ?? 0} ${"views".tr}",
                                    ),
                                  ],
                                ),
                              ],
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
                            GetBuilder<ProductDetailControllerImp>(
                              builder: (controller) => ExpansionTile(
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
                                                        .comments[index]),
                                            separatorBuilder:
                                                (context, index) =>
                                                    SizedBox(height: 16),
                                            itemCount:
                                                controller.comments.length,
                                          )
                                        : Center(child: Text("No Reviews".tr)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 52, top: 12, bottom: 6),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.getMoreComments();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: ColorApp.p_primary,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Text(
                                        'See More Reviews'.tr,
                                        style: TextStyle(
                                            color: ColorApp.p_secondary,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
