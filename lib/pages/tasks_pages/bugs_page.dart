import 'package:flutter/material.dart';
import 'package:osscam/core/resources/color.dart';

class BugsPage extends StatelessWidget {
  const BugsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.textFieldColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
      ),
    );
  }
}
