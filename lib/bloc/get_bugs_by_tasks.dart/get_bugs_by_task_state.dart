// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_bugs_by_task_bloc.dart';

@immutable
sealed class GetBugsByTaskState {}

final class GetBugsByTaskInitial extends GetBugsByTaskState {}

class SuccessGetBugs extends GetBugsByTaskState {
  List<GetBugsModel> bugs;
  SuccessGetBugs({
    required this.bugs,
  });
}

class FailedGetBugs extends GetBugsByTaskState {}

class OfflineGetBugs extends GetBugsByTaskState {}

class LoadingGetBugs extends GetBugsByTaskState {}
