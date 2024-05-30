part of 'project_task_bloc.dart';

@immutable
sealed class ProjectTaskState {}

final class ProjectTaskInitial extends ProjectTaskState {}

class ProjectTaskLoading extends ProjectTaskState {}

class ProjectTaskSuccess extends ProjectTaskState {
  final List<GetAllTasks> tasks;
  ProjectTaskSuccess(this.tasks);
  ProjectTaskSuccess copyWith({
    List<GetAllTasks>? task,
  }) {
    return ProjectTaskSuccess(
      tasks ?? this.tasks,
    );
  }
}

class ProjectTaskError extends ProjectTaskState {
  //final string message;
}

class ProjectTaskOffline extends ProjectTaskState {}

// class AfterUpdateTaskStausSuccess extends ProjectTaskState{}

// class AfterUpdateTaskStausFaild extends ProjectTaskState{}
// class ProjectTaskSilentLoading extends ProjectTaskState {}
