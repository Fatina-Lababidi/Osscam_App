import 'package:flutter/material.dart';
import 'package:osscam/model/create_new_task.dart';

class ItemWidget extends StatelessWidget {
  final CreateNewTaskModel itemDescription;
  final Function(BuildContext, CreateNewTaskModel, Color, Color, String) onTap;
  final Color color;
  final Color textColor;
  final String status;

  const ItemWidget(this.itemDescription, this.onTap, this.color, this.textColor, this.status);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onDoubleTap: () => onTap(
        context,
        itemDescription,
        color,
        textColor,
        status,
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: screenWidth * 0.2, //150,
        height: 73,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Center(
          child: Text(itemDescription.taskDescription),
        ),
      ),
    );
  }
}
