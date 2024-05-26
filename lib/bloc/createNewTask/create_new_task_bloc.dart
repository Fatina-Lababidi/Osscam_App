import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/create_new_task.dart';

import 'package:osscam/service/create_new_task.dart';


part 'create_new_task_event.dart';
part 'create_new_task_state.dart';

class CreateNewTaskBloc extends Bloc<CreateNewTaskEvent, CreateNewTaskState> {
  CreateNewTaskBloc() : super(CreateNewTaskInitial2()) {
    on<CreateNewTask>((event, emit) async {
      try {
        emit(LoadingCreateTask2());
        var temp = await createNewTask(event.taskModel);
        if (temp is String) {
          emit(ErrorCreateTask2());
          // CreateNewTaskEvent;
        } else {
           CreateNewTaskModel taskModel = CreateNewTaskModel.fromMap(temp);
          emit(SuccessCreateTask2(taskModel: taskModel));
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineCreateTask2());
        } else {
          emit(ErrorCreateTask2());
        }
      }
    });
  }
}
