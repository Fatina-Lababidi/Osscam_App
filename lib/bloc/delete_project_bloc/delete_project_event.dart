// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delete_project_bloc.dart';

@immutable
sealed class DeleteProjectEvent {}

// ignore: must_be_immutable
class DeleteProject extends DeleteProjectEvent {
  int projectId;
  DeleteProject({
    required this.projectId,
  });
}

class RefreshProjects extends DeleteProjectEvent {}