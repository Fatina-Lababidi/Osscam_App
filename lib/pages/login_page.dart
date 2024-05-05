import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:osscam/bloc/auth_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/login_user_model.dart';
import 'package:osscam/pages/create_project_page.dart';
import 'package:osscam/pages/signin_page.dart';
import 'package:osscam/widgets/app_textfield_app.dart';
import 'package:page_transition/page_transition.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHieght = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height:screenHieght*0.6,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: 288,
                        height: 360,
                        decoration: BoxDecoration(
                            color: AppColors.continerColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 90,
                            ),
                            LoginTextField(
                              text: "Email",
                              hintText: "Example@gmail.com",
                              controller: email,
                            ),
                            BlocListener<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is Success) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CreateProjectPage(),
                                      ));
                                }
                              },
                              child: LoginTextField(
                                text: "Password",
                                controller: password,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 70,
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: CircleAvatar(
                            backgroundColor: AppColors.imageContinerColor,
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: CircleAvatar(
                                backgroundColor: AppColors.textFieldColor,
                                child: Image(
                                    image: AssetImage(AppImages.iconImage)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                    width: 283,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.buttonColor,
                    ),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthInitial) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(Login(
                                      usermodel: LoginUserModel(
                                    email: email.text,
                                    password: password.text,
                                  )));
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColor),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonColor),
                          );
                        } else if (state is Success) {
                          return Container(
                            color: Colors.green,
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Icon(Icons.check),
                            ),
                          );
                        } else if (state is Failed) {
                          return Container(
                            color: Colors.red,
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Icon(Icons.check),
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                         PageTransition(child: SigninPage(), type:PageTransitionType.fade)
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: AppColors.textFieldColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      )),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
