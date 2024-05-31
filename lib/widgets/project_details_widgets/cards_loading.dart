import 'package:flutter/material.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  ShimmerWidget({required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    // Define colors for each column
    final List<Color> columnColors = [
      AppColors.cardPurpleColor,
      AppColors.cardApricotColor,
      AppColors.cardGreenColor,
    ];

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (columnIndex) {
          return Column(
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Stack(
                children: [
                  Container(
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Shimmer.fromColors(
                      period: const Duration(seconds: 5),
                      baseColor: columnColors[columnIndex].withOpacity(0.3),
                      highlightColor: columnColors[columnIndex].withOpacity(0.6),
                      child: Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Stack(
                children: [
                  Container(
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Shimmer.fromColors(
                      period: const Duration(seconds: 5),
                      baseColor: columnColors[columnIndex].withOpacity(0.3),
                      highlightColor: columnColors[columnIndex].withOpacity(0.6),
                      child: Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}


