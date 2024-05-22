import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/app_bloc/app_bloc.dart';
import 'package:osscam/bloc/login_bloc/auth_bloc.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/login_user_model.dart';
import 'package:osscam/pages/create_or_join_page.dart';
import 'package:osscam/pages/error_page.dart';
import 'package:osscam/pages/offline_page.dart';
import 'package:osscam/pages/sign_up_page.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:osscam/widgets/app_textfield_login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     final SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     var token = await sharedPreferences.getString('token');
  //     if (token != null) {
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return
        // BlocBuilder<AppBloc, AppState>(
        //   builder: (context, state) {
        //     if (state is HeLoggedIn) {
        //       return CreateOrJoinPage();
        //     } else {

        //       return
        BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Done')));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateOrJoinPage(),
                  ),
                );
                context.read<AppBloc>().add(LoggedIn());
              } else if (state is AuthOffline) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Offline,please try later')));
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: OfflinePage(
                          previousPage: LogInPage(),
                        ),
                        type: PageTransitionType.fade));
              } else if (state is AuthFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error,please try again')));
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: ErrorPage(previousPage: LogInPage()),
                      type: PageTransitionType.fade,
                    ));
              }
            },
            child: SingleChildScrollView(
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
                      } else {
                        return const CircularProgressIndicator(
                          color: AppColors.continerColor,
                        );
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
      }),
    );
  }
  //  },
  // );

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
    return LoginTextField(
      secretPassword: IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: _obscureText == false
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility),
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
    ).animate().fade(delay: .7.seconds, duration: .8.seconds);
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
              isChecked = value!;
              // isChecked = !isChecked;
              config.get<SharedPreferences>().setBool('remember me', isChecked);
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
                child: SignUpPage(),
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
