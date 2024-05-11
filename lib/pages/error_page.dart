import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  void initState() {
    print('error');
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
            Text(
              'Something',
              style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  color: Colors.white,
                  fontFamily: 'Frijole'),
            ).animate().fade(duration: .2.seconds,delay: .3.seconds),
            Text(
              'went wrong !',
              style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  color: Colors.white,
                  fontFamily: 'Frijole'),
            ).animate().fade(duration: .4.seconds,delay: .5.seconds),
            Image(
              width: screenWidth * 0.8,
              height: screenHeight * 0.5,
              image: const AssetImage(
                AppImages.errorImage,
              ),
            ).animate().fade(duration: .6.seconds,delay: .7.seconds),
          ],
        ),
      ),
    );
  }
}
