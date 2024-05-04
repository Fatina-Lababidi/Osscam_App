part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class Signup extends SignupEvent {
  SignupUserModel user;
  Signup({
    required this.user,
  });
  
}