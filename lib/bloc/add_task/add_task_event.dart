// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskEvent {}

// class CreateNewTextFiel extends AddTaskEvent {}

class SendAllTask extends AddTaskEvent {
  List<CreateNewTaskModel> tasks;
  SendAllTask({
    required this.tasks,
  });
}

// class SubmitOneTask extends AddTaskEvent {
//   CreateNewTaskModel oneTask;
//   SubmitOneTask({
//     required this.oneTask,
//   });
// }
