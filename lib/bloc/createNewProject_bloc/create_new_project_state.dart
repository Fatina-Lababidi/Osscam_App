part of 'create_new_project_bloc.dart';

@immutable
sealed class CreateNewProjectState {}

final class CreateNewProjectInitial extends CreateNewProjectState {}

class SuccessCreateProject extends CreateNewProjectState{}

class ErrorCreateProject extends CreateNewProjectState{}

class LoadingCreateProject extends CreateNewProjectState{}

class OfflineCreateProject extends CreateNewProjectState{}