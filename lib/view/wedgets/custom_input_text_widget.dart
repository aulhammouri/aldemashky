import 'package:ecommercecourse/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomInputTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? valid;
  final String text;
  final String hintText;
  final Icon icon;
  final TextInputType? keyboardType;
  final bool? obscure;
  final void Function()? onTapIcon;
  const CustomInputTextWidget(
      {super.key,
      required this.text,
      required this.icon,
      required this.hintText,
      required this.controller,
      required this.valid,
      this.keyboardType,
      this.obscure,
      this.onTapIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: valid,
      keyboardType: keyboardType,
      obscureText: obscure == null || obscure == false ? false : true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Text(text),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        suffixIcon: InkWell(
          onTap: onTapIcon,
          child: icon,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: ColorApp.textInputBorderColor, width: 1.5),
        ),
      ),
    );
  }
}
