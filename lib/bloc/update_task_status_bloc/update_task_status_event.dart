// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_task_status_bloc.dart';

@immutable
sealed class UpdateTaskStatusEvent {}

//! we can make a model from this data and use them rather this ..

// ignore: must_be_immutable
class UpdateEvent extends UpdateTaskStatusEvent {
  int project_id;
  int task_id;
  String taskStatus;
  String taskDescription;
  UpdateEvent({
    required this.task_id,
    required this.project_id,
    required this.taskStatus,
    required this.taskDescription,
  });
}
