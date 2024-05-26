part of 'update_task_status_bloc.dart';

@immutable
sealed class UpdateTaskStatusState {}

final class UpdateTaskStatusInitial extends UpdateTaskStatusState {}

class FailedUpdate extends UpdateTaskStatusState {} //error

class SuccessUpdate extends UpdateTaskStatusState {
  // GetAllTasks task ;
}

class OfflineUpdate extends UpdateTaskStatusState {}

class LoadingUpdate extends UpdateTaskStatusState {}
