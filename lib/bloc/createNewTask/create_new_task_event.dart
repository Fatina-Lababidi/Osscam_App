// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_new_task_bloc.dart';

@immutable
sealed class CreateNewTaskEvent {}

// i need int value : id , and i will get it from projectModel
class CreateNewTask extends CreateNewTaskEvent {
//  int id;
  CreateNewTaskModelWithColor createNewTaskModel;
  CreateNewTask({
  //  required this.id,
    required this.createNewTaskModel,
  });
}
