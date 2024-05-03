import 'package:flutter/material.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/Change_Language_page.dart';

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
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ChangeLanguagePage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Welcome",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
          )),
          SizedBox(
            height: 100,
          ),
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.welcomeImage))),
            ),
          ),
        ],
      ),
    );
  }
}
