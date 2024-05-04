part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

class Success extends SignupState{}

class Failed extends SignupState{}

class Loading extends SignupState{}