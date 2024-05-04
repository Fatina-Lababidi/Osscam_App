import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

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
          ).animate().fade(duration: .2.seconds, delay: .1.seconds),
          SizedBox(
            height: screenHeight * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                    "English",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ).animate().fade(duration: .6.seconds, delay: .5.seconds),
                ),
              ).animate().fade(duration: .4.seconds, delay: .3.seconds),
              SizedBox(
                width: screenWidth * 0.1,
              ),
              Container(
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
                  ).animate().fade(duration: .6.seconds, delay: .5.seconds),
                ),
              ).animate().fade(duration: .4.seconds, delay: .3.seconds),
            ],
          ),
        ],
      ),
    );
  }
}
