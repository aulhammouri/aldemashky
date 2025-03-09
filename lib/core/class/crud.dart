import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ecommercecourse/core/class/statusrequest.dart';
import 'package:ecommercecourse/core/functions/checkinternet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../functions/snack.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(
      String linkurl, Map body, String token, String method) async {
    if (await checkInternet()) {
      var response =
          await http.post(Uri.parse(linkurl), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
        'X-HTTP-Method-Override': method,
      });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 403 ||
          response.statusCode == 404) {
        print("==========================statusCode: ${response.statusCode}");
        if (response.headers['content-type']!.contains('application/json')) {
          Map responsebody = jsonDecode(response.body);
          return Right({
            "statusCode": response.statusCode,
            "body": responsebody,
          });
        } else {
          print("=============================== ${'serverfailure1'}");
          print("==========================statusCode: ${response.statusCode}");
          snack("Error".tr, "Server error".tr, Icons.wifi_tethering_error,
              'danger');
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        snack("Error".tr, "Server error".tr, Icons.wifi_tethering_error,
            'danger');
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      snack("Error".tr, "No internet connection".tr, Icons.wifi_off, 'danger');
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> getData(
      String linkurl, String token) async {
    if (await checkInternet()) {
      var response = await http.get(Uri.parse(linkurl), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      print(
          "======================+++++++++++++++++==== ${response.statusCode}");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 403 ||
          response.statusCode == 404) {
        if (response.headers['content-type']!.contains('application/json')) {
          Map responsebody = jsonDecode(response.body);
          return Right({
            "statusCode": response.statusCode,
            "body": responsebody,
          });
        } else {
          print("=============================== ${'serverfailure1'}");
          print("==========================statusCode: ${response.statusCode}");
          snack("Error".tr, "Server error".tr, Icons.wifi_tethering_error,
              'danger');
          return const Left(StatusRequest.serverfailure);
        }
      } else if (response.statusCode == 404) {
        return const Left(StatusRequest.serverfailure);
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
