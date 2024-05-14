import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/create_new_project_model.dart';
import 'package:osscam/model/create_new_task.dart';
import 'package:osscam/service/create_new_task.dart';

part 'create_new_task_event.dart';
part 'create_new_task_state.dart';

class CreateNewTaskBloc extends Bloc<CreateNewTaskEvent, CreateNewTaskState> {
  CreateNewTaskBloc() : super(CreateNewTaskInitial()) {
    on<CreateNewTask>((event, emit) async {
      try {
        emit(LoadingCreateTask());
        dynamic temp = await createNewTask(event.createNewTaskModel);
        if (temp) {
          emit(SuccessCreateTask());
        } else {
          emit(ErrorCreateTask());
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineCreateTask());
        } else {
          emit(ErrorCreateTask());
        }
      }
    });
  }
}
