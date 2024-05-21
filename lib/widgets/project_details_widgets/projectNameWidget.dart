import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/widgets/project_details_widgets/pupUpMenuWidget.dart';


class projectNameWidget extends StatelessWidget {
  const projectNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
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
            },
          ),
          const Spacer(),
          const Text(
    //?we will change this to widget.name depand on the prject we tap on
            "project name",
            style: TextStyle(fontSize: 25, color: Colors.white),
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
            width: 2,
          ),
          PopUpMenuWidget(),
        ],
      ).animate().fade(duration: .4.seconds, delay: .3.seconds),
    );
  }
}
