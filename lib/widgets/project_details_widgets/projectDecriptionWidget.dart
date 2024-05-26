import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/color.dart';

class ProjectDescriptionWidget extends StatelessWidget {
  final String text;
  final String lessText;
  final bool isExpanded;
  final void Function() changeContainerExpanded;
  const ProjectDescriptionWidget(
      {super.key,
      required this.text,
      required this.lessText,
      required this.isExpanded,
      required this.changeContainerExpanded});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Container(
          padding: const EdgeInsets.all(20),
          // duration: const Duration(
          //   milliseconds: 500,
          // ),
          // curve: Curves.easeInOut,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          //! second way : this better
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: RichText(
              text: TextSpan(
                  text: isExpanded ? text : lessText,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppColors.inputTextColor),
                  children: [
                    TextSpan(
                      text: isExpanded ? "read less" : " .... Read more",
                      style: const TextStyle(
                        color: AppColors.textFieldColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textFieldColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = changeContainerExpanded,
                    ),
                  ]),
            ).animate().fade(duration: .7.seconds, delay: .6.seconds),
          )

          //!! first try : the problem of this that the text(read more) under the text but we need it next to
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(_isExpanded ? text : lessText),
          //     //  const SizedBox(
          //     //     height: 10,
          //     //   ),
          //     Align(
          //       alignment: Alignment.bottomRight,
          //       child: GestureDetector(
          //         onTap: _changeContainerExpanded,
          //         child: Text(
          //           _isExpanded ? "read less" : '...read more',
          //           style: const TextStyle(
          //               color: AppColors.textFieldColor,
          //               decoration: TextDecoration.underline,
          //               decorationColor: AppColors.textFieldColor),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          ),
    ).animate().fade(duration: .6.seconds, delay: .5.seconds);
  }
}
