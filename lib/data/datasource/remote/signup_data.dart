import 'package:ecommercecourse/core/class/crud.dart';

class SignupData {
  Crud crud;

  SignupData(this.crud);

  requestData(url, body, token, method) async {
    var response = method == 'GET'
        ? await crud.getData(url, token)
        : await crud.postData(url, body, token, method);
    return response.fold((l) => l, (r) => r);
  }
}
