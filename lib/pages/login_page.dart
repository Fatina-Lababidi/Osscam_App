import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:osscam/bloc/auth_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/login_user_model.dart';
import 'package:osscam/pages/create_or_join_page.dart';
import 'package:osscam/pages/signin_page.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:osscam/widgets/app_textfield_login.dart';
import 'package:page_transition/page_transition.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();
  final _logInFormKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final screenHieght = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHieght * 0.8,
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
                          //! add form
                          child: Form(
                            key: _logInFormKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 90,
                                ),
                                LoginTextField(
                                  validate: validateEmail,
                                  text: "Email",
                                  hintText: "Example@gmail.com",
                                  controller: email,
                                ).animate().fade(
                                    delay: .5.seconds, duration: .6.seconds),
                                BlocListener<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is Success) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateOrJoinPage(),
                                        ),
                                      );
                                      // if (state is Success) {
                                      //   context.read<AppBloc>().add(SigendUp()); // coding that in SignUpPage only .. don't know here what should we do?
                                      // }
                                      //Todo AppBloc
                                    }
                                  },
                                  child: LoginTextField(
                                    secretPassword: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscureText = !obscureText;
                                        });
                                      },
                                      icon: obscureText == false
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                      color: AppColors.primaryColor,
                                    ),
                                    obscureText: obscureText,
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 8) {
                                        return 'Password must be at least 8 characters long';
                                      }
                                      return null;
                                    },
                                    text: "Password",
                                    controller: password,
                                  ).animate().fade(
                                      delay: .7.seconds, duration: .8.seconds),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Checkbox(
                                        activeColor: AppColors.primaryColor,
                                        value: isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked = !isChecked;
                                          });
                                        }),
                                    Text(
                                      "Remember me",
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: screenWidth * 0.04, //15
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ).animate().fade(
                                    delay: .9.seconds, duration: 1.seconds)
                              ],
                            ),
                          ),
                        ),
                      ).animate().fade(delay: .3.seconds, duration: .4.seconds),
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
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthInitial) {
                      return ButtonApp(
                        color: AppColors.buttonColor,
                        text: "Login",
                        textColor: AppColors.primaryColor,
                        onTap: () {
                          //!change here : add if
                          if (_logInFormKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  Login(
                                    usermodel: LoginUserModel(
                                      email: email.text,
                                      password: password.text,
                                    ),
                                  ),
                                );
                          }
                        },
                      ).animate().fade(delay: .5.seconds, duration: .6.seconds);
                      //  ElevatedButton(
                      //   onPressed: () {
                      //     context.read<AuthBloc>().add(
                      //           Login(
                      //             usermodel: LoginUserModel(
                      //               email: email.text,
                      //               password: password.text,
                      //             ),
                      //           ),
                      //         );
                      //   },
                      //   child: Center(
                      //     child: Text(
                      //       "Login",
                      //       style: TextStyle(
                      //         fontSize: 30,
                      //         fontWeight: FontWeight.w400,
                      //         color: AppColors.primaryColor,
                      //       ),
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
                      "Don’t have an account?",
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
                            child: SigninPage(),
                            type: PageTransitionType.fade,
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColors.textFieldColor,
                          fontSize: screenWidth * 0.04, //15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ).animate().fade(delay: .7.seconds, duration: .8.seconds)
              ],
            ),
          ),
        );
      }),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter your email';
    }
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}
