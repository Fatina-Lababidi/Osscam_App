import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:shimmer/shimmer.dart';

class ProjectDetailsLoadingWidget extends StatelessWidget {
  const ProjectDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return  Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Shimmer.fromColors(
          period: const Duration(seconds: 5),
          baseColor: AppColors.continerColor.withOpacity(0.3),
          highlightColor: AppColors.continerColor.withOpacity(0.6),
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight*0.02,),
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
                ).animate().fade(delay: .2.seconds,duration: .3.seconds),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.25,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ).animate().fade(delay: .4.seconds,duration: .5.seconds),
                SizedBox(height:screenHeight*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Container(
                          // margin: const EdgeInsets.all(10),
                          width: screenWidth * 0.3, //150,
                          height: screenHeight * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ).animate().fade(delay: .6.seconds,duration: .7.seconds),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Container(
                          // margin: const EdgeInsets.all(10),
                          width: screenWidth * 0.3, //150,
                          height: screenHeight * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ).animate().fade(delay: .8.seconds,duration: .9.seconds),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Container(
                          // margin: const EdgeInsets.all(10),
                          width: screenWidth * 0.3, //150,
                          height: screenHeight * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ).animate().fade(delay: .6.seconds,duration: .7.seconds),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Container(
                          // margin: const EdgeInsets.all(10),
                          width: screenWidth * 0.3, //150,
                          height: screenHeight * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ).animate().fade(delay: .8.seconds,duration: .9.seconds),
                      ],
                    ),
                     Column(children: [
                   SizedBox(
                  height: screenHeight * 0.01,
                ),
                Container(
                  // margin: const EdgeInsets.all(10),
                  width: screenWidth * 0.3, //150,
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ).animate().fade(delay: .6.seconds,duration: .7.seconds),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Container(
                  // margin: const EdgeInsets.all(10),
                  width: screenWidth * 0.3, //150,
                  height: screenHeight * 0.1,

                ),
                ],)
                  ],
                )
              ],
            ),
          ),
        ),

    );
  }
}
