import 'package:ecommercecourse/controller/about_us_controller.dart';
import 'package:ecommercecourse/core/constant/const.dart';
import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../wedgets/aboutus_carousel.dart';

class AboutUs extends StatelessWidget {
  AboutUsControllerImp controller = Get.put(AboutUsControllerImp());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // الصورة في أعلى الصفحة
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage(ImageAssets.aboutus), // استخدم الصورة المطلوبة
                  //fit: BoxFit.cover,
                ),
              ),
            ),

            // النص الذي يوضح فكرة المنصة
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      Const.aboutUsTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // اللون الأساسي الأخضر
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    Const.aboutUsBody,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  AboutusCarousel(
                    said: controller.said,
                  ),
                  SizedBox(height: 20),

                  // قسم "تواصل معنا"
                  Text(
                    'contact us'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // اللون الأساسي الأخضر
                    ),
                  ),
                  SizedBox(height: 15),

                  // العنوان مع أيقونة
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Text(
                        Const.siteAdress,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // الهاتف مع أيقونة
                  InkWell(
                    onTap: () {
                      controller.callAuther();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                        SizedBox(width: 10),
                        Text(
                          Const.sitePhone,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  InkWell(
                    onTap: () {
                      controller.whatsappAuthor();
                    },
                    borderRadius:
                        BorderRadius.circular(10), // تأثير دائري عند الضغط
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.whatsapp,
                          width: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          Const.siteWhatsUp,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  // البريد الإلكتروني مع أيقونة
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          controller.emailAuthor();
                        },
                        child: Text(
                          'contact@aldemashqy.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
