import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/service/delete_project_service.dart';

part 'delete_project_event.dart';
part 'delete_project_state.dart';

class DeleteProjectBloc extends Bloc<DeleteProjectEvent, DeleteProjectState> {
  DeleteProjectBloc() : super(DeleteProjectInitial()) {
    on<DeleteProject>((event, emit) async {
      try {
        emit(LoadingDeleteProject());
        bool temp = await deleteProjectService(event.projectId);
        if (temp) {
          emit(SuccessDeleteProject());
        } else {
          emit(FailedDeleteProject());
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineDeleteProject());
        } else {
          emit(FailedDeleteProject());
        }
      }
    });
  }
}
