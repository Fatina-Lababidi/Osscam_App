part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// ignore: must_be_immutable
class Login extends AuthEvent {
  LoginUserModel usermodel;
  Login({
    required this.usermodel,
  });
  
}
