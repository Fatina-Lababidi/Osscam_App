import 'package:flutter/material.dart';
import 'package:osscam/model/get_tasks_model.dart';

class ItemWidget extends StatelessWidget {
  final GetAllTasks itemDescription;
  final Function(BuildContext, GetAllTasks, Color, Color, String) onTap;
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
        margin: const EdgeInsets.all(5),
        width:170,// screenWidth * 0.2, //150,
        height:65,// 73,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        child: Center(
          child: Text(itemDescription.taskDescription),
        ),
      ),
    );
  }
}
