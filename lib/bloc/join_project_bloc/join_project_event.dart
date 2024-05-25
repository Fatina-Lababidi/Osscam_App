// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'join_project_bloc.dart';

@immutable
sealed class JoinProjectEvent {}

class Join extends JoinProjectEvent {
  int projectId;
  Join({
    required this.projectId,
  });
}
