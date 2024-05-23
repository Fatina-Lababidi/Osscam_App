import 'package:flutter/material.dart';
import 'package:osscam/core/resources/color.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 234,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.cardPurpleColor,
          ),
          child: Center(child: TextField(
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          )),
        ),
      ),
    );
  }
}