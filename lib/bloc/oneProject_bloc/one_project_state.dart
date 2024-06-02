// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'one_project_bloc.dart';

@immutable
sealed class OneProjectState {}

final class OneProjectInitial extends OneProjectState {}

// ignore: must_be_immutable
class SuccessOneProject extends OneProjectState {
  ProjectsModel projectsModel;
  SuccessOneProject({
    required this.projectsModel,
  });
}

class ErrorOneProject extends OneProjectState {}

class LoadingOneProject extends OneProjectState {}

class OfflineOneProject extends OneProjectState {}
