import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/app_bloc/app_bloc.dart';
import 'package:osscam/bloc/sign_up_bloc/signup_bloc.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/register_model.dart';
import 'package:osscam/pages/create_or_join_page.dart';
import 'package:osscam/pages/error_page.dart';
import 'package:osscam/pages/login_page.dart';
import 'package:osscam/pages/offline_page.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:osscam/widgets/app_textfield_login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool obscureText = true;
  final prefs = config<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is HeSigendUp) {
          return LogInPage();
        } else {
          return BlocProvider(
            create: (context) => SignupBloc(),
            child: Builder(builder: (context) {
              return Scaffold(
                  backgroundColor: AppColors.primaryColor,
                  body: BlocListener<SignupBloc, SignupState>(
                      listener: (context, state) {
                        if (state is Success) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Done')));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateOrJoinPage(),
                            ),
                          );
                        } else if (state is Offline) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Offline')));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OfflinePage(),
                            ),
                          );
                        } else if (state is Failed) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Error')));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ErrorPage(),
                            ),
                          );
                        }
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      decoration: BoxDecoration(
                                        color: AppColors.continerColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Form(
                                        key: _formKey,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 80),
                                              LoginTextField(
                                                validate: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your first name';
                                                  }
                                                  return null;
                                                },
                                                text: "First Name",
                                                hintText: "Example",
                                                controller: firstName,
                                              ).animate().fade(
                                                    delay: .3.seconds,
                                                    duration: .4.seconds,
                                                  ),
                                              LoginTextField(
                                                validate: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your last name';
                                                  }
                                                  return null;
                                                },
                                                text: "Last Name",
                                                hintText: "Example",
                                                controller: lastName,
                                              ).animate().fade(
                                                    delay: .5.seconds,
                                                    duration: .6.seconds,
                                                  ),
                                              LoginTextField(
                                                validate: validateEmail,
                                                text: "Email",
                                                hintText: "Example@gmail.com",
                                                controller: email,
                                              ).animate().fade(
                                                    delay: .7.seconds,
                                                    duration: .8.seconds,
                                                  ),
                                              LoginTextField(
                                                validate: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your password';
                                                  }
                                                  if (value.length < 8) {
                                                    return 'Password must be at least 8 characters long';
                                                  }
                                                  return null;
                                                },
                                                secretPassword: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      obscureText =
                                                          !obscureText;
                                                    });
                                                  },
                                                  icon: obscureText == false
                                                      ? const Icon(
                                                          Icons.visibility)
                                                      : const Icon(
                                                          Icons.visibility_off),
                                                  color: AppColors.primaryColor,
                                                ),
                                                obscureText: obscureText,
                                                text: "Password",
                                                controller: password,
                                              ).animate().fade(
                                                    delay: .9.seconds,
                                                    duration: .8.seconds,
                                                  ),
                                              Row(
                                                children: [
                                                  SizedBox(width: 20),
                                                  Checkbox(
                                                    activeColor:
                                                        AppColors.primaryColor,
                                                    value: isChecked,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isChecked = !isChecked;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "Remember me",
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                ],
                                              ).animate().fade(
                                                    delay: 1.1.seconds,
                                                    duration: 1.seconds,
                                                  )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(1),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.19,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.imageContinerColor,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.16,
                                            child: const CircleAvatar(
                                              backgroundColor:
                                                  AppColors.textFieldColor,
                                              child: Image(
                                                image: AssetImage(
                                                    AppImages.iconImage),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ).animate().fade(
                                          delay: .1.seconds,
                                          duration: .2.seconds,
                                        ),
                                  ],
                                ),
                              ),
                            ),
                            _buildSignUpButton(),
                            SizedBox(height: 30),
                            _buildLoginRow(),
                          ],
                        ),
                      )));
            }),
          );
        }
      },
    );
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        if (state is SignupInitial) {
          return ButtonApp(
            text: "Sign Up",
            color: AppColors.buttonColor,
            textColor: AppColors.primaryColor,
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                context.read<SignupBloc>().add(
                      Signup(
                        user: SignupUserModel(
                          firstName: firstName.text,
                          lastName: lastName.text,
                          email: email.text,
                          password: password.text,
                          role: "USER",
                        ),
                      ),
                    );
                var temp = Signup(
                  user: SignupUserModel(
                    firstName: firstName.text,
                    lastName: lastName.text,
                    email: email.text,
                    password: password.text,
                    role: "USER",
                  ),
                );
                if (await temp is String) {
                  Future<void> saveUserToken(String token) async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('user_token', token);
                  }
                }
              }
            },
          ).animate().fade(
                delay: .5.seconds,
                duration: .6.seconds,
              );
          // } else if (state is Success) {
          //   return Container(
          //     color: Colors.green,
          //     width: 100,
          //     height: 50,
          //     child: const Center(
          //       child: Icon(Icons.check),
          //     ),
          //   );
          // } else if (state is Failed) {
          //   return Container(
          //     color: Colors.red,
          //     width: 100,
          //     height: 50,
          //     child: const Center(
          //       child: Icon(Icons.check),
          //     ),
          //   );
        } else {
          return const CircularProgressIndicator(
            color: AppColors.continerColor,
          );
        }
      },
    );
  }

  Widget _buildLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account ?",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
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
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
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
