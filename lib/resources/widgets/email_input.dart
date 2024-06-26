import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../utils/app_colors.dart';


class EmailInputWidget extends StatelessWidget {
  String title;
  late Color hintcolour;
  bool isPassword = false;
  bool validate = true;
  TextInputType keyboardType = TextInputType.text;
  ValueChanged<String?> value;
  bool isRequired = false;
  String? error;
  IconData? icon;

  double width;
  TextEditingController? controller;


  EmailInputWidget(
      {Key? key,
        required this.title,
        required this.isRequired,
        required this.keyboardType,
        required this.value,
        required this.width,
        required this.validate,
        required this.isPassword,
        this.controller,
        this.icon,
        this.error,
        required this.hintcolour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller:controller,
      cursorColor: AppColors.textBlue,
      showCursor: true,
      obscureText: isPassword,
      style: TextStyle(color:hintcolour),
      textInputAction: TextInputAction.done,
      keyboardType: keyboardType,


      decoration: InputDecoration(
       prefixIcon: IconButton(
         icon: const Icon(Icons.email),
         color: AppColors.black, onPressed: () {  },
       ),
        filled: true,
          fillColor: AppColors.primaryColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: new BorderSide(color: AppColors.black,)),
          hintText: title,
          alignLabelWithHint: true,
            labelText: title,
          hintStyle: TextStyle(color: hintcolour)),
      validator: (value) {
        if (validate || value!.isEmpty) {
          return EmailValidator.validate(value!) ? null : 'Please enter valid ' + title;


        }
      },
      onSaved: value,
    );
  }
}