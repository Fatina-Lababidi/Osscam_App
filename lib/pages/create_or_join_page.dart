import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/widgets/app_button.dart';

//360*800
class CreateOrJoinPage extends StatefulWidget {
  const CreateOrJoinPage({super.key});

  @override
  State<CreateOrJoinPage> createState() => _CreateOrJoinPageState();
}

class _CreateOrJoinPageState extends State<CreateOrJoinPage> {
  bool _isContainerVisible = false;
  final _joinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isContainerVisible = false;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Stack(
                    children: [
                      Image(
                        width: screenWidth * 413.73,
                        height: screenHeight * 0.33526, //335.26,
                        image: const AssetImage(
                          AppImages.polygonImage,
                        ),
                      ).animate().fade(duration: .4.seconds, delay: .3.seconds),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.05, right: screenWidth * 0.1),
                        child: Image(
                          width: screenWidth * 3.0314,
                          height: screenHeight * 0.2148,
                          image: const AssetImage(
                            AppImages.osscamImage,
                          ),
                        )
                            .animate()
                            .fade(duration: .4.seconds, delay: .3.seconds),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.06,
                  ),
                  Column(children: [
                    ButtonApp(
                            textColor: AppColors.primaryColor,
                            color: AppColors.buttonColor,
                            text: 'Create',
                            onTap: () {
                              print('create');
                              print('${MediaQuery.of(context).size}');
                            })
                        .animate()
                        .fadeIn(duration: .6.seconds, delay: .5.seconds),
                    SizedBox(
                      height: //20
                          screenHeight / 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isContainerVisible = true;
                        });
                      },
                      child: DottedBorder(
                        color: AppColors.buttonColor,
                        borderType: BorderType.RRect,
                        strokeWidth: 1,
                        dashPattern: const [12, 5],
                        radius: const Radius.circular(15),
                        child: SizedBox(
                          width: screenWidth * 0.8, //283,
                          height: screenHeight * 0.08, //60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                width: screenWidth / 9,
                                height: screenHeight / 9, //35
                                image: const AssetImage(
                                  AppImages.addImage,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 20,
                              ),
                              Text(
                                'Join',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.03,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fade(duration: .8.seconds, delay: .7.seconds),
                  ]),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(
                milliseconds: 700,
              ),
              curve: Curves.easeInOut,
              top: _isContainerVisible ? screenHeight * 0.53 : screenHeight,
              left: 0,
              right: 0,
              //  bottom: _isContainerVisible? 0:null,
              child: Container(
                height: _isContainerVisible ? screenHeight : 0,
                decoration: const BoxDecoration(
                  color: AppColors.textFieldColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enter project’s",
                                style: TextStyle(
                                    fontSize: screenHeight * 0.03,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor),
                              ),
                              Text(
                                "ID..",
                                style: TextStyle(
                                    fontSize: screenHeight * 0.03,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Image(
                              width: //100,
                                  screenWidth * 0.2,
                              height: //100,
                                  screenHeight * 0.1,
                              image: const AssetImage(
                                AppImages.cypressImage,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.020,
                      ),
                      TextFormField(
                        controller: _joinController,
                        cursorColor: AppColors.textColor,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the id';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      ButtonApp(
                        text: 'Confirm',
                        color: AppColors.primaryColor,
                        textColor: Colors.white,
                        onTap: () {
                          //valediate
                          if (_joinController.text.isNotEmpty) {
                            //navigate
                            print('validate');
                          } else {
                            print('emty');
                            //show Dialog ?
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}