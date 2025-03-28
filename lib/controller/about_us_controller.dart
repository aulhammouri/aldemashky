import 'dart:async';

import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core/constant/const.dart';

abstract class AboutUsController extends GetxController {
  callAuther();
  emailAuthor();
  whatsappAuthor();
}

class AboutUsControllerImp extends AboutUsController {
  List<Map<String, dynamic>> said = [
    {
      'image': '',
      'icon': '',
      'name': 'سارة',
      'nickname': ' صاحبة متجر إلكتروني',
      'body':
          'بفضل منصة الدمشقي، زادت مبيعاتي بشكل ملحوظ. الخدمات المبتكرة جعلت عملي أكثر احترافية',
      'stars': '',
    },
    {
      'image': '',
      'icon': '',
      'name': 'أحمد',
      'nickname': ' صاحب شركة تجارية',
      'body':
          'منصة الدمشقي غيرت طريقة تعاملي مع التسويق! سهلة الاستخدام وتوفر كل ما أحتاجه في مكان واحد',
      'stars': '',
    },
    {
      'image': '',
      'icon': '',
      'name': 'محمد',
      'nickname': 'رائد أعمال',
      'body':
          'منصة متكاملة بكل معنى الكلمة. ساعدتني في الوصول إلى عملاء جدد وتوسيع نشاطي التجاري',
      'stars': '',
    }
  ];
  int currentIndex = 0;
  PageController pageController1 = PageController();

  @override
  void onInit() {
    pageController1 = PageController(initialPage: 0);
    initCarosel();
    super.onInit();
  }

  @override
  void dispose() {
    pageController1.dispose();
    super.dispose();
  }

  @override
  Future<void> callAuther() async {
    final url = "tel:${Const.sitePhone}";
    try {
      if (true) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      SnackBar(content: Text('Problem while open phone'.tr));
    }
  }

  @override
  Future<void> emailAuthor() async {
    final email = Const.siteEmail;
    final subject = Const.emailUsSubject;
    final body = Const.emailUsBody;
    final url =
        'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
    try {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      SnackBar(content: Text('Problem while opening email'.tr));
    }
  }

  @override
  Future<void> whatsappAuthor() async {
    final url =
        'https://wa.me/${Const.siteWhatsUp}?text=${Const.whatsUpMessage}';
    try {
      if (true) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      SnackBar(content: Text('Proplem while open whatsapp'.tr));
    }
  }

  void initCarosel() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (!pageController1.hasClients)
        return; // التأكد من أن `pageController` متصل بـ `PageView`

      if (currentIndex < said.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      pageController1.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}
