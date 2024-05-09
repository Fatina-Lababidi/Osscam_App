part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

// ignore: must_be_immutable
class Signup extends SignupEvent {
  SignupUserModel user;
  Signup({
    required this.user,
  });
  
}