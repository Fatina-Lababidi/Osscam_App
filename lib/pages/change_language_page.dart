import 'package:flutter/material.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/login_page.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage(AppImages.waitingImage)),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.buttonColor,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                            Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LogInPage();
          },
        ),
      );
                      },
                      child: Text(
                        "English",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor),
                    )),
              ),
              SizedBox(
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.buttonColor,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "العربية",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
