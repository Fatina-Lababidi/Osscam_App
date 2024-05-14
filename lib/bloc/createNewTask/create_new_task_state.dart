part of 'create_new_task_bloc.dart';

@immutable
sealed class CreateNewTaskState {}

final class CreateNewTaskInitial extends CreateNewTaskState {}

class SuccessCreateTask extends CreateNewTaskState {}

class ErrorCreateTask extends CreateNewTaskState {}

class LoadingCreateTask extends CreateNewTaskState {}

class OfflineCreateTask extends CreateNewTaskState {}

