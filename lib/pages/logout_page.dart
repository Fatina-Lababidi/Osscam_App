import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/widgets/app_button.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ).animate().fade(duration: .2.seconds, delay: .1.seconds),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Stack(
                  children: [
                    Image(
                      width: screenWidth * 413.73,
                      height: screenHeight * 0.33526, //335.26,
                      image: const AssetImage(
                        AppImages.polygonImage,
                      ),
                    ).animate().fade(duration: .4.seconds, delay: .3.seconds),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.05, right: screenWidth * 0.1),
                      child: Image(
                        width: screenWidth * 3.0314,
                        height: screenHeight * 0.2148,
                        image: const AssetImage(
                          AppImages.osscamImage,
                        ),
                      ).animate().fade(duration: .4.seconds, delay: .3.seconds),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Text(
                  "Are you sure you want",
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      color: Colors.white,
                      fontFamily: 'Frijole'),
                ).animate().fade(duration: .6.seconds, delay: .5.seconds),
                Text(
                  "to logout ??",
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      color: Colors.white,
                      fontFamily: 'Frijole'),
                ).animate().fade(duration: .8.seconds, delay: .7.seconds),
                SizedBox(
                  height: screenHeight * 0.25,
                ),
                ButtonApp(
                  text: "Logout",
                  onTap: () {

                  },
                  color: AppColors.buttonColor,
                  textColor: AppColors.primaryColor,
                ).animate().fade(duration: 1.seconds, delay: .9.seconds),
              ],
            ),
          ),
        );
      }
    );
  }
}
