import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/bloc/project_task_bloc/project_task_bloc.dart';
import 'package:osscam/service/update_task_status_service.dart';

part 'update_task_status_event.dart';
part 'update_task_status_state.dart';

class UpdateTaskStatusBloc
    extends Bloc<UpdateTaskStatusEvent, UpdateTaskStatusState> {
 // final ProjectTaskBloc projectTaskBloc;
  UpdateTaskStatusBloc(
  //  this.projectTaskBloc
    )
      : super(UpdateTaskStatusInitial()) {
    on<UpdateEvent>((event, emit) async {
      try {
        emit(LoadingUpdate());
        bool temp = await updateTaskStatus(event.task_id, event.taskDescription,
            event.taskStatus, event.project_id);
        print(temp);
        if (temp) {
          emit(SuccessUpdate());
       //   projectTaskBloc.add(AfterUpdate(projectId: event.project_id));
        } else {
          emit(FailedUpdate());
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineUpdate());
        } else {
          emit(FailedUpdate());
        }
      }
    });
  }
}
