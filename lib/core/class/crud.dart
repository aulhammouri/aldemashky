import 'dart:convert';
import 'dart:io';
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
      try {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        var response = await http
            .get(Uri.parse("$linkurl?timestamp=$timestamp"), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cache-Control': 'no-cache', // تعديل خطأ إملائي من Cashe إلى Cache
          'Pragma': 'no-cache'
        });

        print(
            "====================== Response Status Code: ${response.statusCode}");

        if ([200, 201, 403, 404].contains(response.statusCode)) {
          try {
            if (response.headers['content-type']
                    ?.contains('application/json') ??
                false) {
              Map responsebody = jsonDecode(response.body);
              return Right({
                "statusCode": response.statusCode,
                "body": responsebody,
              });
            } else {
              print(
                  "==========================statusCode: ${response.statusCode}");
              snack("Error".tr, "Server error".tr, Icons.wifi_tethering_error,
                  'danger');
              return const Left(StatusRequest.serverfailure);
            }
          } catch (e) {
            print("JSON Parsing Error: $e");
            return const Left(StatusRequest.serverfailure);
          }
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } on SocketException catch (e) {
        print("Network Error: $e");
        return const Left(StatusRequest.offlinefailure);
      } on FormatException catch (e) {
        print("Invalid JSON Format: $e");
        return const Left(StatusRequest.serverfailure);
      } catch (e) {
        print("Unexpected Error: $e");
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> postDataMultipart(String linkurl, Map body,
      File image, String? token, String method) async {
    if (await checkInternet()) {
      var request = http.MultipartRequest('POST', Uri.parse(linkurl));
      if (token != null) {
        request.headers['Authorization'] = token;
      }
      request.headers['Accept'] = "application/json";
      //request.headers['Content-Type'] = "video/mp4";
      if (image.path != "") {
        var file = await http.MultipartFile.fromPath(
          'file',
          image.path,
        );
        request.files.add(file);
      }

      request.fields['data'] = jsonEncode(body);
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print(("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"));
      print("==========================statusCode: ${response.statusCode}");
      print("==========================response: ${jsonDecode(responseBody)}");

      if (response.statusCode == 200 ||
          response.statusCode == 403 ||
          response.statusCode == 404) {
        print("==========================statusCode: ${response.statusCode}");

        if (response.headers['content-type']!.contains('application/json')) {
          Map responsebody = jsonDecode(responseBody);
          return Right({
            "statusCode": response.statusCode,
            "body": responsebody,
          });
        } else {
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
}
