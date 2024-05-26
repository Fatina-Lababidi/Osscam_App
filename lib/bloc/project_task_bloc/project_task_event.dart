part of 'project_task_bloc.dart';

@immutable
sealed class ProjectTaskEvent {}

class GetTasksByProject extends ProjectTaskEvent {
  final int projectId;

  GetTasksByProject(this.projectId);
}

// class AfterUpdate extends ProjectTaskEvent{}