import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/create_project_page.dart';
import 'package:osscam/pages/signin_page.dart';
import 'package:osscam/widgets/app_textfield_app.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 500,
             child: Stack(
                  alignment: AlignmentDirectional.center,
                     children: [
                       Container(
                        width: 288,
                        height: 360,
                        decoration: BoxDecoration(
                            color: AppColors.continerColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(height: 90,),
                            TextFieldApp(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  "Password",
                                  style: TextStyle(color: AppColors.primaryColor,fontSize: 15,fontWeight: FontWeight.w400),
                                ),
                                subtitle: Container(
                                  width: 226,
                                  height: 43,
                                  decoration: BoxDecoration(
                                    color:   AppColors.textFieldColor.withOpacity(0.75),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextField(
                                    controller: password,
                                    decoration: InputDecoration(
                                        fillColor:
                                            AppColors.textFieldColor.withOpacity(0.75),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: AppColors.primaryColor)),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                       Positioned(
                         top:0,
                         left: 70,
                         child: SizedBox(
                            width: 140,
                                     height: 140,
                                     child: CircleAvatar(
                                      
                                       backgroundColor: AppColors.imageContinerColor,
                                       child: SizedBox(
                                         width: 120,
                                         height: 120,
                                         child: CircleAvatar(
                                           backgroundColor: AppColors.textFieldColor,
                                           child: Image(image: AssetImage(AppImages.iconImage)),
                                         ),
                                       ),
                                     ),
                                   ),
                       ),
                  
                     ], 
                   
                      ),
            ),
          ),
          Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: 283,
                  height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.buttonColor,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                            Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CreateProjectPage();
          },
        ),
      );
                      },
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor),
                    )),
              ),
              SizedBox(height: 30,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don’t have an account?",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              TextButton(
                  onPressed: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SigninPage();
          },
        ),
      );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: AppColors.textFieldColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          )
                  ], 
              
        
        
        
        
        
      ),
    );
  }
}
