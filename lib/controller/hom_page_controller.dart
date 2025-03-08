import 'package:ecommercecourse/core/services/services.dart';
import 'package:get/get.dart';

abstract class HomPageController extends GetxController {}

class HomPageControllerImp extends HomPageController {
  MyServices myServices = Get.find();
  late String? user_email;
  bool? isLogedIn;

  @override
  void onInit() {
    user_email = myServices.sharedPreferences.getString("user_email");
    isLogedIn = myServices.sharedPreferences.getBool("isLogedIn");

    update();
    super.onInit();
  }
}
