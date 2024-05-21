import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:osscam/model/create_new_task.dart';

class ExpandedCard extends StatelessWidget {
  final CreateNewTaskModelWithColor task;
  final Color color;
  final String status;
  final Color textAndIconColor;
  const ExpandedCard({Key? key, required this.task, required this.color, required this.status, required this.textAndIconColor});

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
            // child: Container(
            //   width: screenWidth * 0.8,
            //   height: screenHeight * 0.5,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            child: SizedBox(
              height: screenHeight * 0.5,
              width: screenWidth * 0.8,
              child: Card(
                elevation: 8,
                color: color, // Colors.orange[100],
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              status,
                              style: TextStyle(color: textAndIconColor),
                            ),
                            Icon(
                              Icons.pest_control_outlined,
                              color:textAndIconColor,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: screenWidth * 0.7, //150,
                        height: screenHeight * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(task.taskDescription),
                        ),
                      ),
                    ],
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
