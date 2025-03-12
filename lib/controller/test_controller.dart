import 'package:ecommercecourse/core/class/statusrequest.dart';
import 'package:ecommercecourse/core/functions/handingdatacontroller.dart';
import 'package:ecommercecourse/data/datasource/remote/test_data.dart';
import 'package:get/get.dart';

import '../core/services/services.dart';
import '../linkapi.dart';

class TestController extends GetxController {
  TestData testData = TestData(Get.find());
  MyServices myService = Get.find();

  List data = [];
  bool? isLogedin;

  late StatusRequest statusRequest;

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await testData.requestData(AppLink.test, {}, '', 'GET');
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (true) {
        //response.total_pages > 0
        data.addAll(response['ads']);
      }
      //  else {
      //   statusRequest = StatusRequest.failure;
      // }
    }
    update();
  }

  @override
  void onInit() {
    isLogedin = myService.sharedPreferences.getBool('isLogedin');
    getData();
    super.onInit();
  }
}
