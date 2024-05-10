// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'projects_bloc.dart';

@immutable
sealed class ProjectsState {}

final class ProjectsInitial extends ProjectsState {}

// ignore: must_be_immutable
class SuccessGetProjects extends ProjectsState {
  List<ProjectsModel> projects;
  SuccessGetProjects({
    required this.projects,
  });
}

class ErrorGetProjects extends ProjectsState {}

class LoadingGetProjects extends ProjectsState {}

class OfflineOnGetProjects extends ProjectsState {}
