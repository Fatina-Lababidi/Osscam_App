// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_new_task_bloc.dart';

@immutable
sealed class CreateNewTaskState {}

final class CreateNewTaskInitial2 extends CreateNewTaskState {}

class SuccessCreateTask2 extends CreateNewTaskState {
  CreateNewTaskModel taskModel;
  SuccessCreateTask2({
    required this.taskModel,
  });
}
// we can make it return a model of createNewtaskModel, and make the service also return it , maybe this benifit in projects?
class ErrorCreateTask2 extends CreateNewTaskState {}

class LoadingCreateTask2 extends CreateNewTaskState {}

class OfflineCreateTask2 extends CreateNewTaskState {}

