// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'one_project_bloc.dart';

@immutable
sealed class OneProjectEvent {}

class GetOneProject extends OneProjectEvent {
  int projectId;
  GetOneProject({
    required this.projectId,
  });
}
