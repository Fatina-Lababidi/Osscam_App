// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_bugs_by_task_bloc.dart';

@immutable
sealed class GetBugsByTaskEvent {}

class GetBugs extends GetBugsByTaskEvent {
  int taskId;
  GetBugs({
    required this.taskId,
  });
}
