// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_new_project_bloc.dart';

@immutable
sealed class CreateNewProjectState {}

final class CreateNewProjectInitial extends CreateNewProjectState {}

// ignore: must_be_immutable
class SuccessCreateProject extends CreateNewProjectState {
  ProjectsModel project;
  SuccessCreateProject({
    required this.project,
  });
}

class ErrorCreateProject extends CreateNewProjectState {}

class LoadingCreateProject extends CreateNewProjectState {}

class OfflineCreateProject extends CreateNewProjectState {}
