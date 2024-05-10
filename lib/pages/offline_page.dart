import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  void initState() {
    print('offline');
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image(
                  width: screenWidth * 1,
                  height: screenHeight * 0.5,
                  image: const AssetImage(
                    AppImages.noInternetVectorImage,
                  ),
                ).animate().fade(duration: .2.seconds,delay: .3.seconds),
                Image(
                  width: screenWidth * 1,
                  height: screenHeight * 0.55,
                  image: const AssetImage(
                    AppImages.noInternetImage,
                  ),
                ).animate().scaleXY(duration: .4.seconds,delay: .5.seconds),
              ],
            ),
            Text(
              "No internet ..",
              style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontFamily: 'Frijole',
                  color: Colors.white),
            ).animate().fade(duration: .6.seconds,delay: .7.seconds),
          ],
        ),
      ),
    );
  }
}
