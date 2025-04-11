import 'package:ecommercecourse/view/screen/aboutus.dart';
import 'package:ecommercecourse/view/screen/edit_product.dart';
import 'package:ecommercecourse/view/screen/home_page.dart';
import 'package:ecommercecourse/view/screen/product_detail.dart';
import 'package:ecommercecourse/view/screen/products_manging.dart';
import 'package:get/get.dart';
import 'core/constant/approutes.dart';

//import 'core/middleware/staging_middleware.dart';
import 'core/middleware/staging_middleware.dart';
import 'test_view.dart';
import 'view/screen/add_product.dart';
import 'view/screen/auth/login_screan_small.dart';
import 'view/screen/auth/login_screen.dart';
import 'view/screen/auth/password_recover.dart';
import 'view/screen/auth/signup_screan.dart';
import 'view/screen/product_grid_page.dart';

List<GetPage<dynamic>>? routes = [
  // GetPage(name: "/", page: () => const Language() , middlewares: [
  //   MyMiddleWare()
  // ]),
  //GetPage(name: "/", page: () => TestView()),

  GetPage(name: AppRoutes.home, page: () => HomePage()),
  GetPage(name: AppRoutes.homepage, page: () => HomePage()),
  GetPage(name: AppRoutes.aboutus, page: () => AboutUs()),

  GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  GetPage(name: AppRoutes.loginsmall, page: () => LoginScreenSmall()),

  GetPage(name: AppRoutes.passwordrecover, page: () => PasswordRecover()),
  GetPage(name: AppRoutes.signup, page: () => SignupScrean()),
  GetPage(name: AppRoutes.test, page: () => const TestView()),
  GetPage(name: AppRoutes.productdetail, page: () => ProductDetail()),
  GetPage(name: AppRoutes.addproduct, page: () => AddProduct()),
  GetPage(name: AppRoutes.editproduct, page: () => EditProduct()),
  GetPage(
    name: AppRoutes.managProducts,
    page: () => ProductsManging(),
    //middlewares: [StagingMiddleware()]
  ),
];
