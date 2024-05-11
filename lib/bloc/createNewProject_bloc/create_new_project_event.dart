part of 'create_new_project_bloc.dart';

@immutable
sealed class CreateNewProjectEvent {}

// ignore: must_be_immutable
class CreateNewProject extends CreateNewProjectEvent {
  CreateNewProjectModel project;
  CreateNewProject({required this.project});
}
