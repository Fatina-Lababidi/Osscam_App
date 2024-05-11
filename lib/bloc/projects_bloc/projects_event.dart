// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'projects_bloc.dart';

@immutable
sealed class ProjectsEvent {}

class GetProjects extends ProjectsEvent {
  ProjectsModel projectsM;
  GetProjects({
    required this.projectsM,
  });
}
