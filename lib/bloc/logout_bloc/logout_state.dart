part of 'logout_bloc.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}

class Success extends LogoutState{}

class Failed extends LogoutState{}

class Loading extends LogoutState{}

class Offline extends LogoutState{}
