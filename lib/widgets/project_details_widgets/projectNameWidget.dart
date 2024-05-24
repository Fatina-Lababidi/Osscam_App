import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/delete_project_bloc/delete_project_bloc.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/widgets/project_details_widgets/pupUpMenuWidget.dart';

class projectNameWidget extends StatelessWidget {
  final String name;
  final int projectId;
  const projectNameWidget({
    super.key,
    required this.name,
    required this.projectId,
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
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: AppColors.primaryColor,
              size: 30,
            ),
            onPressed: () {
              //? here the drawer
              Scaffold.of(context).openDrawer();
            },
          ),
          const Spacer(),
          Text(
            //?we will change this to widget.name depand on the prject we tap on
            name,
            // "project name",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.05, //screenHeight * 0.03, //25,
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
          PopUpMenuWidget(
            projectId: projectId,
          ),
        ],
      ).animate().fade(duration: .4.seconds, delay: .3.seconds),
    );
  }
}
