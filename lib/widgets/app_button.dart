import 'package:flutter/material.dart';
import 'package:osscam/core/resources/asset.dart';

<<<<<<< HEAD
class IconButtonPassword extends StatelessWidget {
   IconButtonPassword({super.key});
bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
                      onPressed: () {},
                      icon: (isPressed)?Icon(
                        Icons.remove_red_eye,
                        size: 20,
                        color: Color.fromARGB(186, 24, 90, 92),
                      ):Image(image: AssetImage(AppImages.visibilityImage))
                      );  }
=======
class ButtonApp extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  const ButtonApp({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: screenWidth * 0.8, //283,
          height: screenHeight * 0.08, //60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 4,
                )
              ]),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
>>>>>>> update_ui
}


