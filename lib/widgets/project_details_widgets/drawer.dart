import 'package:flutter/material.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/create_new_project_page.dart';
import 'package:osscam/pages/create_or_join_page.dart';
import 'package:osscam/pages/logout_page.dart';
import 'package:page_transition/page_transition.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return Drawer(
      backgroundColor: AppColors.drawerColor,
      width: screenWidth * 0.6,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Container(
            padding: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.15,
            child: const CircleAvatar(
              backgroundColor: AppColors.textFieldColor,
              child: Image(
                image: AssetImage(AppImages.iconImage),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Text(
            'user name',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.05,
              //fontWeight: FontWeight.bold,
              fontFamily: 'Frijole',
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Divider(
            color: AppColors.drawerDetailsColor,
            endIndent: 5,
            indent: 5,
            thickness: 0.5,
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          ListTile(
            leading: Icon(
              Icons.link,
              color: AppColors.drawerDetailsColor,
            ),
            title: Text(
              'Create & Join',
              style: TextStyle(
                color: AppColors.drawerDetailsColor,
                fontSize: screenWidth / 20,
                fontWeight: FontWeight.w200,
              ),
            ),
            onTap: () {
              //navigate to create page
              Navigator.push(
                  context,
                  PageTransition(
                      child: CreateOrJoinPage(),
                      type: PageTransitionType.fade));
            },
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          ListTile(
            leading: Icon(
              Icons.library_books,
              color: AppColors.drawerDetailsColor,
            ),
            title: Text(
              'change language',
              style: TextStyle(
                color: AppColors.drawerDetailsColor,
                fontSize: screenWidth / 20,
                fontWeight: FontWeight.w200,
              ),
            ),
            onTap: () {
              //navigate to change language page
            },
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: AppColors.drawerDetailsColor,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: AppColors.drawerDetailsColor,
                fontSize: screenWidth / 20,
                fontWeight: FontWeight.w200,
              ),
            ),
            onTap: () {
              //navigate to change language page
              Navigator.push(
                context,
                PageTransition(
                    child: LogoutPage(), type: PageTransitionType.fade),
              );
            },
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Divider(
            color: AppColors.drawerDetailsColor,
            endIndent: 5,
            indent: 5,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
