part of 'logout_bloc.dart';

@immutable
sealed class LogoutEvent {}
class Logout extends LogoutEvent {
  LogoutModel logOutModel;
  Logout({
    required this.logOutModel,
  });
  
}