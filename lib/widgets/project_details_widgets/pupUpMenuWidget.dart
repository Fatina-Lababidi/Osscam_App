import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/color.dart';


class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (value) {
        switch (value) {
          case 1:
            //what will delet exactually??
            break;
          case 2:
            // edit : will nav to the create or what ?
            break;
          case 3:
            //copy Id ;
            break;
        }
      },
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: AppColors.buttonColor,
      popUpAnimationStyle: AnimationStyle(
          curve: Curves.easeInOut, duration: .2.seconds),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: AppColors.dropTextColor,
                  ),
                  Text(
                    "Delete",
                    style: TextStyle(
                        fontSize: 10,
                        color: AppColors.dropTextColor),
                  )
                ],
              ),
              Divider()
            ],
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.mode_edit_outline_rounded,
                    color: AppColors.dropTextColor,
                  ),
                  Text(
                    "Edit",
                    style: TextStyle(
                        fontSize: 10,
                        color: AppColors.dropTextColor),
                  )
                ],
              ),
              Divider(),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(
                Icons.copy,
                color: AppColors.dropTextColor,
              ),
              Text(
                "Copy ID",
                style: TextStyle(
                    fontSize: 10, color: AppColors.dropTextColor),
              )
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
    );
  }
}


