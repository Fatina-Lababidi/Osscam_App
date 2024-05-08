import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.8,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    _buildLoginForm(screenWidth, screenHeight),
                    _buildAvatar(screenWidth, screenHeight),
                  ],
                ),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitial) {
                    return _buildLoginButton(context);
                    // }
                    //else if (state is Success) {
                    //   return _buildSuccessIndicator();
                    // } else if (state is Failed) {
                    //   return _buildFailedIndicator();
                  } else {
                    return _buildLoadingIndicator();
                  }
                },
              ),
              SizedBox(height: 30),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.55,
      decoration: BoxDecoration(
        color: AppColors.continerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 90),
              _buildEmailTextField(),
              _buildPasswordTextField(),
              _buildRememberMeCheckbox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return LoginTextField(
      validate: validateEmail,
      text: "Email",
      hintText: "Example@gmail.com",
      controller: _emailController,
    ).animate().fade(delay: .5.seconds, duration: .6.seconds);
  }

  Widget _buildPasswordTextField() {
    return BlocListener<AuthBloc, AuthState>(
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
        }
      },
      child: LoginTextField(
        secretPassword: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: _obscureText == false
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
          color: AppColors.primaryColor,
        ),
        obscureText: _obscureText,
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
        controller: _passwordController,
      ).animate().fade(delay: .7.seconds, duration: .8.seconds),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Row(
      children: [
        SizedBox(width: 20),
        Checkbox(
          activeColor: AppColors.primaryColor,
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
            color: AppColors.primaryColor,
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    ).animate().fade(delay: .9.seconds, duration: 1.seconds);
  }

  Widget _buildAvatar(double screenWidth, double screenHeight) {
    return Positioned(
      top: 0,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        width: screenWidth * 0.4,
        height: screenHeight * 0.19,
        child: CircleAvatar(
          backgroundColor: AppColors.imageContinerColor,
          child: SizedBox(
            width: screenWidth * 0.4,
            height: screenHeight * 0.16,
            child: const CircleAvatar(
              backgroundColor: AppColors.textFieldColor,
              child: Image(
                image: AssetImage(AppImages.iconImage),
              ),
            ),
          ),
        ),
      ),
    ).animate().fade(delay: .1.seconds, duration: .2.seconds);
  }

  Widget _buildLoginButton(BuildContext context) {
    return ButtonApp(
      color: AppColors.buttonColor,
      text: "Login",
      textColor: AppColors.primaryColor,
      onTap: () {
        if (_formKey.currentState!.validate()) {
          context.read<AuthBloc>().add(
                Login(
                  usermodel: LoginUserModel(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                ),
              );
        }
      },
    ).animate().fade(delay: .5.seconds, duration: .6.seconds);
  }

  // Widget _buildSuccessIndicator() {
  //   return Container(
  //     color: Colors.green,
  //     width: 100,
  //     height: 50,
  //     child: const Center(
  //       child: Icon(Icons.check),
  //     ),
  //   );
  // }

  // Widget _buildFailedIndicator() {
  //   return Container(
  //     color: Colors.red,
  //     width: 100,
  //     height: 50,
  //     child: const Center(
  //       child: Icon(Icons.check),
  //     ),
  //   );
  // }

  Widget _buildLoadingIndicator() {
    return const CircularProgressIndicator(
      color: AppColors.continerColor,
    );
  }

  Widget _buildSignUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account?",
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
                child: SigninPage(),
                type: PageTransitionType.fade,
              ),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: AppColors.textFieldColor,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ).animate().fade(delay: .7.seconds, duration: .8.seconds);
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}
