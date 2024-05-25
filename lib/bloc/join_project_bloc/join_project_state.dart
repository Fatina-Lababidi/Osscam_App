part of 'join_project_bloc.dart';

@immutable
sealed class JoinProjectState {}

final class JoinProjectInitial extends JoinProjectState {}

class LoadingJoinProject extends JoinProjectState{}

class SuccessJoinProject extends JoinProjectState{}

class ErrorJoinProject extends JoinProjectState{}

class OfflineJoinProject extends JoinProjectState{}