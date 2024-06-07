import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/tasks/addBugsPage.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class BugsNameWidget extends StatelessWidget {
  final String name;
  IconData? icon;
  final int bugsId;
  final bool hasBugs;
  final int taskId;
  final int projectId;
  final String projectName;
  final String projectDescription;

  BugsNameWidget({
    super.key,
    required this.name,
    this.icon,
    required this.bugsId,
    required this.hasBugs,
    required this.taskId,
    required this.projectId,
    required this.projectName,
    required this.projectDescription,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      height: screenHeight * 0.07, // 51,
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
          const SizedBox(width: 5),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: screenWidth * 0.07, // screenHeight * 0.03, // 25,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  PageTransition(
                    child: AddBugsPage(
                      hasBugs: hasBugs,
                      taskId: taskId,
                      projectId: projectId,
                      projectName: projectName,
                      projectDescription: projectDescription,
                      bugId: bugsId,
                    ),
                    type: PageTransitionType.fade,
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.dropTextColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Add Bugs",
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.dropTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 5),
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  PageTransition(
                    child: AddBugsPage(
                      hasBugs: hasBugs,
                      taskId: taskId,
                      projectId: projectId,
                      projectName: projectName,
                      projectDescription: projectDescription,
                      bugId: bugsId,
                    ),
                    type: PageTransitionType.fade,
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.dropTextColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Add Bugs",
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.dropTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ).animate().fade(duration: .4.seconds, delay: .3.seconds),
    );
  }
}
