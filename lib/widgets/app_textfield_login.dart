import 'package:flutter/material.dart';
import 'package:osscam/core/resources/color.dart';

// ignore: must_be_immutable
class LoginTextField extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  String? text;
  IconButton? secretPassword;
  String? Function(String?)? validate;
  Color fillColor;
  bool obscureText;
  double width;
  double height;
  LoginTextField({
    super.key,
    this.hintText,
    this.controller,
    this.text,
    this.secretPassword,
    this.validate,
    this.fillColor = AppColors.textFieldColor,
    this.obscureText = false,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  withLockedPassword(String lockedPassword) {
    secretPassword = lockedPassword as IconButton?;
    return this;
  }

  withHintText(String hintText) {
    hintText = hintText;
    return this;
  }

  withText(String text) {
    text = text;
    return this;
  }

  withController(TextEditingController controller) {
    controller = controller;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          text!, //! here appeare exeption !!
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Container(
          width: width == double.infinity
              ? screenWidth * 0.7
              : width, //screenWidth * 0.7, //226,
          height: height == double.infinity
              ? screenHeight * 0.07
              : height, // screenHeight * 0.07, //43
          decoration: BoxDecoration(
              color: fillColor, //AppColors.textFieldColor.withOpacity(0.75),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            cursorHeight: 20,
            obscureText: obscureText,
            validator: validate,
            cursorColor: AppColors.primaryColor,
            controller: controller,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: AppColors.primaryColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor:
                  fillColor, // AppColors.textFieldColor.withOpacity(0.75),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              hintText: hintText,
              hintStyle:
                  const TextStyle(color: AppColors.primaryColor, fontSize: 12),
              suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: secretPassword,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
