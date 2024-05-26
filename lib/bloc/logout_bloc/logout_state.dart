// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'logout_bloc.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}

// ignore: must_be_immutable
class LogOutSuccess extends LogoutState {
  String message;
  LogOutSuccess({
    required this.message,
  });
}

class LogOutFailed extends LogoutState {}

class LogOutLoading extends LogoutState {}

class LogOutOffline extends LogoutState {}
