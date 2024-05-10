part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

class SignUpSuccess extends SignupState{}

class SignUpFailed extends SignupState{}

class SignUpLoading extends SignupState{}

class SignUpOffline extends SignupState{}