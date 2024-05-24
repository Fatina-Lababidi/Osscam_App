import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:shimmer/shimmer.dart';

class ProjectsLoadingWidget extends StatelessWidget {
  const ProjectsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Shimmer.fromColors(
        period: const Duration(seconds: 5),
        baseColor: AppColors.continerColor.withOpacity(0.3),
        highlightColor: AppColors.continerColor.withOpacity(0.6),
        child: Center(
          child: Column(
            children: [
             // SizedBox(height: screenHeight*0.01,),
              Container(
                width: screenWidth * 2,
                height: 51,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(left: 5, top: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textFieldColor),
                  borderRadius: BorderRadius.circular(19),
                  color: AppColors.textFieldColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.textFieldColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: screenHeight * 0.13, //105,
                    width: screenWidth * 2, //317,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.25, //135,
                              height: screenHeight * 0.13, //105,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().scaleXY(
                        delay: Duration(milliseconds: 100 + (index * 100)),
                        duration: Duration(milliseconds: 100 + (index * 100)),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
