part of 'app_bloc.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class HeLoggedIn extends AppState {}

class HeLoggedOut extends AppState {}//token = false, firstTime = false >> LogIN Page

class HisFirstTime extends AppState{}// token = false , firstTime = true >> SignUp page

class UseingApp extends AppState{}//token = true, firstTime = false>> get all projects page

class HeJoinApp extends AppState{}//token = true , firstTime = true>> Create & join project