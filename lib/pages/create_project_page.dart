import 'package:flutter/material.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';

class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image(image: AssetImage(AppImages.osscamImage))),

        ],
      ),
    );
  }
}