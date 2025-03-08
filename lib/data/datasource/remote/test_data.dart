import 'package:ecommercecourse/core/class/crud.dart';

class TestData {
  Crud crud;

  TestData(this.crud);

  // getData() async {
  //   var response = await crud.postData(AppLink.test);
  //   print("--------------------${response}");
  //   return response.fold((l) => l, (r) => r);
  //}
  requestData(url, body, token, method) async {
    var response = method == 'GET'
        ? await crud.getData(url, token)
        : await crud.postData(url, body, token, method);
    print("--------------------${response}");
    return response.fold((l) => l, (r) => r);
  }
}
