import 'package:flutter/material.dart';

import '../../core/constant/colors.dart';

class CustomBtnWidget extends StatelessWidget {
  final bool? isLoading;
  final String text;
  final void Function()? onPressed;

  const CustomBtnWidget(
      {super.key, required this.text, this.onPressed, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading == true ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorApp.btnBgColor,
        disabledBackgroundColor: ColorApp.btnDisBgColor,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: isLoading == true
            ? CircularProgressIndicator(
                color: Colors.white,
                //strokeWidth: 2,
              )
            : Text(text,
                style: TextStyle(fontSize: 18, color: ColorApp.btntxtColor)),
      ),
    );
  }
}
