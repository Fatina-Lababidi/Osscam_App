// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_new_task_bloc.dart';

@immutable
sealed class CreateNewTaskState {}

final class CreateNewTaskInitial extends CreateNewTaskState {}

class SuccessCreateTask extends CreateNewTaskState {
  CreateNewTaskModel taskModel;
  SuccessCreateTask({
    required this.taskModel,
  });
}
// we can make it return a model of createNewtaskModel, and make the service also return it , maybe this benifit in projects?
class ErrorCreateTask extends CreateNewTaskState {}

class LoadingCreateTask extends CreateNewTaskState {}

class OfflineCreateTask extends CreateNewTaskState {}

