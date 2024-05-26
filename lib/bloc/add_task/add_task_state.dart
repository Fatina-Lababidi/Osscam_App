// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

class ErrorCreateTask extends AddTaskState {}

class LoadingCreateTask extends AddTaskState {}

class OfflineCreateTask extends AddTaskState {}

// class NewTextFieldCreated extends AddTaskState {
//   List<CreateNewTaskModel> tasks;
//   NewTextFieldCreated({
//     required this.tasks,
//   });
// }

//class AllTaskSended extends AddTaskState {}
//? i just changed the name to be more clear
class SuccessSendingAllTask extends AddTaskState{}

// ? we make this in the ui , so we can delete it ..
// class OneTaskSubmitd extends AddTaskState {}
