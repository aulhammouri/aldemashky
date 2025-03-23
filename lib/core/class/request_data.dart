import 'dart:io';

import 'package:ecommercecourse/core/class/crud.dart';

class RequestData {
  Crud crud;

  RequestData(this.crud);

  requestData(url, body, token, method) async {
    var response = method == 'GET'
        ? await crud.getData(url, token)
        : await crud.postData(url, body, token, method);
    return response.fold((l) => l, (r) => r);
  }

  requestMultipartData(url, body, File image, token, method) async {
    var response =
        await crud.postDataMultipart(url, body, image, token, method);
    return response.fold((l) => l, (r) => r);
  }
}
