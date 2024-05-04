part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class Login extends AuthEvent {
  LoginUserModel usermodel;
  Login({
    required this.usermodel,
  });
  
}
