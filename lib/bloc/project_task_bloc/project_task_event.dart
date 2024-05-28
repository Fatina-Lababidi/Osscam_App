// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'project_task_bloc.dart';

@immutable
sealed class ProjectTaskEvent {}

class GetTasksByProject extends ProjectTaskEvent {
  final int projectId;

  GetTasksByProject(this.projectId);
}

// class AfterUpdate extends ProjectTaskEvent {
//   final int projectId;
//   AfterUpdate({
//     required this.projectId,
//   });
// }
