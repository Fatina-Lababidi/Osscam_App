part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class LoggedIn extends AppEvent {}

class LoggedOut extends AppEvent {}

class SigendUp extends AppEvent {}

class CheckAppStatus extends AppEvent {}