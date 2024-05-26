part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

class ErrorCreateTask extends AddTaskState {}

class LoadingCreateTask extends AddTaskState {}

class OfflineCreateTask extends AddTaskState {}

class NewTextFieldCreated extends AddTaskState {
  List<CreateNewTaskModel> tasks;
  NewTextFieldCreated({
    required this.tasks,
  });
}


class AllTaskSended extends AddTaskState {}

class OneTaskSubmitd extends AddTaskState {}
