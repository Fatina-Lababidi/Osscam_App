import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/login_page.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: screenWidth * 0.7,
            height: screenHeight * 0.25,
            image: const AssetImage(
              AppImages.languageImage,
            ),
          ).animate().fade(duration: Duration(milliseconds: 200), delay: Duration(milliseconds: 100)),
          SizedBox(
            height: screenHeight * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Animate(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.2),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                    ),
                    child: Text(
                      "English",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ).animate().fade(duration: Duration(milliseconds: 600), delay: Duration(milliseconds: 500)),
              SizedBox(
                width: screenWidth * 0.1,
              ),
              Animate(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.2),
                    color: AppColors.buttonColor,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                    ),
                    child: Text(
                      "العربية",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ).animate().fade(duration: Duration(milliseconds: 400), delay: Duration(milliseconds: 300)),
            ],
          ),
        ],
      ),
    );
  }
}
