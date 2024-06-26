import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';


class NameInputWidget extends StatelessWidget {
  String title;
  late Color hintColor;
  Color? errorColor;
  bool isPassword = false;

  bool validate = true;
  TextInputType keyboardType = TextInputType.text;
  ValueChanged<String?> value;
  ValueChanged<String?>? changeValue;

  bool isRequired = false;
  String? error;
  TextEditingController? controller;

  late double? width;
  IconData? icon;
  String? initialVal;
  bool? isEnabled = true;
  late int? maxLines;

  NameInputWidget(
      {Key? key,
      required this.title,
      required this.isRequired,
      required this.keyboardType,
      required this.value,
      this.width,
      required this.validate,
      required this.isPassword,
      required this.hintColor,
      this.error,
      this.errorColor,
      this.icon,
      this.controller,
      this.initialVal,
      this.isEnabled,
      this.maxLines,
      this.changeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: true,
      cursorColor: AppColors.black,

      initialValue: initialVal,
      enabled: isEnabled,
      controller: controller,
      obscureText: isPassword,
      maxLines: maxLines,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      style: TextStyle(color: hintColor),
      decoration: InputDecoration(

        filled: true,
        fillColor: AppColors.primaryColor,
        prefixIcon: Icon(
          icon
        ),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: new BorderSide(color: AppColors.black,)),
        hintText: title,
        labelText: title,
        labelStyle: TextStyle(color: AppColors.greyColor),
        hintStyle: TextStyle(color: AppColors.greyColor),
        errorStyle: TextStyle(
          color: errorColor,
        ),
      ),
      validator: (value) {
        if (validate && value!.length < 1) {
          return error;
        }
      },
      onSaved: value,
      onChanged: changeValue,
    );
  }
}
