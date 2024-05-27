// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delete_project_bloc.dart';

@immutable
sealed class DeleteProjectState {}

final class DeleteProjectInitial extends DeleteProjectState {}

class SuccessDeleteProject extends DeleteProjectState {}

class FailedDeleteProject extends DeleteProjectState {

}

class OfflineDeleteProject extends DeleteProjectState {}

class LoadingDeleteProject extends DeleteProjectState {}
