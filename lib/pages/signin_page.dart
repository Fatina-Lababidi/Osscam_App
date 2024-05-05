import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/signup_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/register_model.dart';
import 'package:osscam/pages/create_or_join_page.dart';
import 'package:osscam/pages/login_page.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:osscam/widgets/app_textfield_login.dart';
import 'package:page_transition/page_transition.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double screenHieght = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: screenHieght * 0.7,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: screenWidth * 0.8, //288,
                        height: screenHieght * 0.55, //360,
                        decoration: BoxDecoration(
                            color: AppColors.continerColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 70,
                              ),
                              LoginTextField(
                                text: "Username",
                                hintText: "Example",
                                controller: firstName,
                              ).animate().fade(
                                  delay: .5.seconds, duration: .6.seconds),
                              LoginTextField(
                                text: "Email",
                                hintText: "Example@gmail.com",
                                controller: email,
                              ).animate().fade(
                                  delay: .7.seconds, duration: .8.seconds),
                              BlocListener<SignupBloc, SignupState>(
                                listener: (context, state) {
                                  if (state is Success) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateOrJoinPage(),
                                      ),
                                    );
                                  }
                                },
                                child: LoginTextField(
                                  text: "Password",
                                  controller: password,
                                ).animate().fade(
                                    delay: .9.seconds, duration: .8.seconds),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0, // screenHieght * 0.1,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          width: screenWidth * 0.4, //142,
                          height: screenHieght * 0.19, //142,
                          child: CircleAvatar(
                            backgroundColor: AppColors.imageContinerColor,
                            child: SizedBox(
                              width: screenWidth * 0.4, //120,
                              height: screenHieght * 0.16, //120,
                              child: const CircleAvatar(
                                backgroundColor: AppColors.textFieldColor,
                                child: Image(
                                  image: AssetImage(AppImages.iconImage),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animate().fade(delay: .1.seconds, duration: .2.seconds),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  if (state is SignupInitial) {
                    return ButtonApp(
                      text: "Sign Up",
                      color: AppColors.buttonColor,
                      textColor: AppColors.primaryColor,
                      onTap: () async {
                        context.read<SignupBloc>().add(Signup(
                            user: SignupUserModel(
                                firstName: firstName.text,
                                lastName: lastName.text,
                                email: email.text,
                                password: password.text,
                                role: "USER")));
                      },
                    ).animate().fade(delay: .5.seconds, duration: .6.seconds);
                    // return ElevatedButton(
                    //   onPressed: () {
                    //     context.read<SignupBloc>().add(
                    //           SignUp(
                    //             SignupUserModel(
                    //               email: email.text,
                    //               password: password.text,
                    //               firstName: firstName.text,
                    //               lastName: lastName.text,
                    //               role: 'USER',
                    //             ),
                    //           ),
                    //         );
                    //   },
                    //   child: Center(
                    //     child: Text(
                    //       "Sign Up",
                    //       style: TextStyle(
                    //           fontSize: 30,
                    //           fontWeight: FontWeight.w400,
                    //           color: AppColors.primaryColor),
                    //     ),
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //       backgroundColor: AppColors.buttonColor),
                    // );
                  } else if (state is Success) {
                    return Container(
                      color: Colors.green,
                      width: 100,
                      height: 50,
                      child: const Center(
                        child: Icon(Icons.check),
                      ),
                    );
                  } else if (state is Failed) {
                    return Container(
                      color: Colors.red,
                      width: 100,
                      height: 50,
                      child: const Center(
                        child: Icon(Icons.check),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: AppColors.continerColor,
                    );
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04, //15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: LogInPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.textFieldColor,
                        fontSize: screenWidth * 0.04, // 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
