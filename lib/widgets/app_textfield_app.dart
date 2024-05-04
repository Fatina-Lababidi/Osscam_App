// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:osscam/core/resources/color.dart';


class LoginTextField extends StatelessWidget {
  String? hinttext;
  TextEditingController? controller;
  String? text;
  IconButton? secretPassword;

  LoginTextField({
    super.key,
    this.hinttext,
    this.controller,
    this.text,
    this.secretPassword,
  });

  withLockedPassword(String lockedPassword) {
    secretPassword = lockedPassword as IconButton?;
    return this;
  }

  withHintText(String hintText) {
    hinttext = hintText;
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
          text!,
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
        subtitle: Container(
          width: screenWidth * 0.7, //226,
          height: screenHeight * 0.07, //43
          decoration: BoxDecoration(
              color: AppColors.textFieldColor.withOpacity(0.75),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                fillColor: AppColors.textFieldColor.withOpacity(0.75),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primaryColor)),
                hintText: hinttext,
                hintStyle: TextStyle(color: AppColors.primaryColor),
                suffixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12.0),
                  child: secretPassword,
              
                )),
          ),
        ),
      ),
    );
  }
}
