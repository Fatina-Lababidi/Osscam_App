import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/tasks_model/get_tasks_model.dart';
import 'package:osscam/service/tasks_service/get_task_by_project_id.dart';

part 'project_task_event.dart';
part 'project_task_state.dart';

class ProjectTaskBloc extends Bloc<ProjectTaskEvent, ProjectTaskState> {
  ProjectTaskBloc() : super(ProjectTaskInitial()) {
    on<GetTasksByProject>((event, emit) async {
      emit(ProjectTaskLoading());
      try {
        final temp = await fetchTasksByProjectId(event.projectId);
        if (temp is String) {
          emit(ProjectTaskError());
        } else {
          List<GetAllTasks> tasks = List.generate(
              temp.length, (index) => GetAllTasks.fromMap(temp[index]));
          emit(ProjectTaskSuccess(tasks));
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(ProjectTaskOffline());
        } else {
          emit(ProjectTaskError());
        }
      }
    });
    // on<AfterUpdate>(
    //   (event, emit)async {
    //     final temp = await fetchTasksByProjectId(event.projectId);
    //       List<GetAllTasks> tasks = List.generate(
    //           temp.length, (index) => GetAllTasks.fromMap(temp[index]));
    //     emit(ProjectTaskInitial());
    //   },
    // );
  }
}
