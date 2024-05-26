part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskEvent {}

class CreateNewTextFiel extends AddTaskEvent {}

class SendAllTask extends AddTaskEvent {}

class SubmitOneTask extends AddTaskEvent {
  CreateNewTaskModel oneTask;
  SubmitOneTask({
    required this.oneTask,
  });
}
