import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/logout_bloc/logout_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/main.dart';
import 'package:osscam/pages/handle_exception_pages/error_page.dart';
import 'package:osscam/pages/handle_exception_pages/offline_page.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:page_transition/page_transition.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context) => LogoutBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: BlocListener<LogoutBloc, LogoutState>(
            listener: (context, state) {
              if (state is LogOutSuccess) {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const MyApp(), type: PageTransitionType.fade));
              } else if (state is LogOutFailed) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                  content: Text(
                    'Error,please try again...',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: AppColors.deleteCardColor,
                  duration: Duration(seconds: 2),
                ));
                Navigator.push(
                  context,
                  PageTransition(
                    child: const ErrorPage(
                      previousPage: LogoutPage(),
                    ),
                    type: PageTransitionType.fade,
                  ),
                );
              } else if (state is LogOutOffline) {
                 ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                  content: Text(
                    'Offline,please try later...',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: AppColors.dropTextColor,
                  duration: Duration(seconds: 2),
                  ));

                Navigator.push(
                    context,
                    PageTransition(
                        child: const OfflinePage(
                          previousPage: LogoutPage(),
                        ),
                        type: PageTransitionType.fade));
              }
            },
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ).animate().fade(duration: .2.seconds, delay: .1.seconds),
                  SizedBox(
                    height: screenHeight * 0.01,
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
                  Text(
                    "Are you sure you want",
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.white,
                        fontFamily: 'Frijole'),
                  ).animate().fade(duration: .6.seconds, delay: .5.seconds),
                  Text(
                    "to logout ??",
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.white,
                        fontFamily: 'Frijole'),
                  ).animate().fade(duration: .8.seconds, delay: .7.seconds),
                  SizedBox(
                    height: screenHeight * 0.25,
                  ),
                  BlocBuilder<LogoutBloc, LogoutState>(
                    builder: (context, state) {
                      if (state is LogoutInitial) {
                        return ButtonApp(
                          text: "Logout",
                          onTap: () {
                            context.read<LogoutBloc>().add(Logout());
                          },
                          color: AppColors.buttonColor,
                          textColor: AppColors.primaryColor,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.buttonColor,
                          ),
                        );
                      }
                    },
                  ).animate().fade(duration: 1.seconds, delay: .9.seconds),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
