import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/Change_Language_page.dart';
import 'package:page_transition/page_transition.dart';

class InterancePage extends StatefulWidget {
  const InterancePage({super.key});

  @override
  State<InterancePage> createState() => _InterancePageState();
}

class _InterancePageState extends State<InterancePage> {
  @override
  void initState() {
    print('initState');
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const ChangeLanguagePage(),
          type: PageTransitionType.fade,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: screenHeight / 4,
              width: screenWidth / 2.2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.welcomeImage),
                ),
              ),
            ),
          )
              .animate()
              .fade(duration: 1.seconds)
              .then()
              .shake(duration: 2.seconds, hz: 2),
          SizedBox(
            height: screenHeight * 0.2,
          ),
          Center(
            child: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth / 10,
                fontWeight: FontWeight.bold,
                fontFamily: 'Frijole',
              ),
            ),
          ).animate().fade(duration: 1.seconds).then().shimmer(),
        ],
      ),
    );
  }
}
