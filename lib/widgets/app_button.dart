import 'package:flutter/material.dart';
import 'package:osscam/core/resources/asset.dart';

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
}


