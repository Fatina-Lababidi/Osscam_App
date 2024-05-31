import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/tasks_model/get_tasks_model.dart';
import 'package:osscam/pages/tasks_pages/addBugsPage.dart';
import 'package:osscam/pages/tasks_pages/bugs_page.dart';
import 'package:page_transition/page_transition.dart';

class ExpandedCard extends StatelessWidget {
  final GetAllTasks task;
  final Color color;
  final String status;
  final Color textAndIconColor;
  final int taskId;
  const ExpandedCard(
      {Key? key,
      required this.task,
      required this.color,
      required this.status,
      required this.textAndIconColor, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Stack(
        children: [
          Blur(
            blur: 5,
            blurColor: Colors.black.withOpacity(0.1),
            colorOpacity: 0.4,
            child: Container(
              width: screenWidth,
              height: screenHeight,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Center(
            child: SizedBox(
              height: screenHeight * 0.5,
              width: screenWidth * 0.8,
              child: Card(
                elevation: 8,
                color: color, // Colors.orange[100],
                child: Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.05,
                      left: screenWidth * 0.02,
                      right: screenWidth * 0.02,
                      bottom: screenHeight * 0.02),
                  child: Container(
                    width: screenWidth * 0.72, //150,
                    height: screenHeight * 0.44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(task.taskDescription),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: GestureDetector(
                              onTap: () {
                                //  context.read<GetBugsByTaskBloc>.
                                //navigate to bug page
                                task.hasBugs?
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: BugsPage(
                                      taskId: taskId,
                                      bugId: 2,
                                      hasBugs: task.hasBugs,
                                    ),
                                    type: PageTransitionType.fade,
                                  ),
                                ): Navigator.push(
                                  context,
                                  PageTransition(
                                    child: AddBugsPage(
                                      taskId: taskId,
                                      bugId: 2,
                                      hasBugs: (task.hasBugs) ? true : false,
                                    ),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                              },
                              child: Container(
                                width: 125,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.bugsButtonColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      )
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.001,
                                      horizontal: screenWidth * 0.01),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        task.hasBugs ? "Show Bugs" : "Add Bugs",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        Icons.pest_control_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ),
          // ),
        ],
      ),
    );
  }
}
