import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../constant/colors.dart';

snack(title, body, icon, type) {
  Get.snackbar(
    title,
    '',
    messageText: Html(
      // ignore: prefer_interpolation_to_compose_strings
      data: "<p style='color: white;'>" + body + "</p>",
    ),
    icon: Icon(icon, color: Colors.white),
    colorText: Colors.white,
    backgroundColor: type == 'success'
        ? ColorApp.snBgSuColor
        : type == 'danger'
            ? ColorApp.snBgErColor
            : ColorApp.snBgInColor,
    borderWidth: 2,
    borderColor: Colors.grey,
    borderRadius: 6,
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
    duration: Duration(seconds: 3),
    animationDuration: Duration(seconds: 1),
  );
}
