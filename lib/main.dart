import 'package:ecommercecourse/core/constant/colors.dart';
import 'package:ecommercecourse/core/localization/translations.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'bindings/intialbindings.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  //view date in arabic
  //timeago.format( DateFormat("yyyy-MM-dd HH:mm:ss") .parse(ads['published_date']),locale: 'ar'),
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // السماح بالوضع العمودي فقط
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app title'.tr,
      translations: MyTranslations(),
      locale: Locale('ar'), //Get.deviceLocale,
      theme: ThemeData(
        fontFamily: 'cairo',
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ColorApp.headLine1Color),
          headlineMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorApp.headLine1Color),
          headlineSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorApp.headLine1Color),
          bodySmall: TextStyle(fontSize: 12, color: ColorApp.bodyTextColor),
          bodyMedium: TextStyle(fontSize: 14, color: ColorApp.bodyTextColor),
          bodyLarge: TextStyle(fontSize: 16, color: ColorApp.bodyTextColor),
        ),
      ),
      //home: LoginScreen(), //OnBoarding()
      initialBinding: InitialBindings(),

      //routes: routes,
      getPages: routes,
    );
  }
}
