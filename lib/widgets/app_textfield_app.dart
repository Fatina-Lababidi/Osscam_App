import 'package:flutter/material.dart';
import 'package:osscam/core/resources/color.dart';

class TextFieldApp extends StatelessWidget {
   TextFieldApp({super.key});
TextEditingController email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          "Email",
                          style: TextStyle(color: AppColors.primaryColor,fontSize: 15,fontWeight: FontWeight.w400),
                        ),
                        subtitle: Container(
                          width: 226,
                          height: 43,
                          decoration: BoxDecoration(
                            color:   AppColors.textFieldColor.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                                fillColor:
                                    AppColors.textFieldColor.withOpacity(0.75),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                hintText: "Example@gmail.com",
                                hintStyle:
                                    TextStyle(color: AppColors.primaryColor)),
                          ),
                        ),
                      ),
                    );
  }
}