import 'package:ecommercecourse/view/screen/home_page.dart';
import 'package:get/get.dart';
import 'core/constant/approutes.dart';

//import 'core/middleware/staging_middleware.dart';
import 'test_view.dart';
import 'view/screen/auth/login_screen.dart';
import 'view/screen/auth/password_recover.dart';
import 'view/screen/auth/signup_screan.dart';
import 'view/screen/category_ads.dart';

List<GetPage<dynamic>>? routes = [
  // GetPage(name: "/", page: () => const Language() , middlewares: [
  //   MyMiddleWare()
  // ]),
  //GetPage(name: "/", page: () => TestView()),

  GetPage(
    name: AppRoutes.home,
    page: () => CategoryAds(),
    // middlewares: [StagingMiddleware()]
  ),
  GetPage(name: AppRoutes.homepage, page: () => HomePage()),
  GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  GetPage(name: AppRoutes.passwordrecover, page: () => PasswordRecover()),
  GetPage(name: AppRoutes.signup, page: () => SignupScrean()),
  GetPage(name: AppRoutes.test, page: () => const TestView()),
];
