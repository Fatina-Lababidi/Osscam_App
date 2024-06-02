// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:osscam/core/resources/color.dart';
// import 'package:osscam/widgets/project_details_widgets/pupUpMenuWidget.dart';

// ignore: must_be_immutable
class BugsNameWidget extends StatelessWidget {
  final String name;
   IconData? icon;
   BugsNameWidget({
    super.key,
    required this.name,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      height: screenHeight * 0.07, //51,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textFieldColor),
        borderRadius: BorderRadius.circular(19),
        color: AppColors.textFieldColor,
      ),
      child: Row(
        children: [
          Icon(
          icon,
           color: AppColors.primaryColor,
              size: 30,
          ),
          SizedBox(width: 5,),
          Text(
            //?we will change this to widget.name depand on the prject we tap on
            name,
            // "project name",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.07, //screenHeight * 0.03, //25,
                color: Colors.white),
          ),
          const Spacer(),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ).animate().fade(duration: .4.seconds, delay: .3.seconds),
    );
  }
}
