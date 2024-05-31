import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/service/projects_service/joinToProject_service.dart';

part 'join_project_event.dart';
part 'join_project_state.dart';

class JoinProjectBloc extends Bloc<JoinProjectEvent, JoinProjectState> {
  JoinProjectBloc() : super(JoinProjectInitial()) {
    on<Join>((event, emit) async {
      emit(LoadingJoinProject());
      try {
        bool temp = await joinProjectService(event.projectId);
        if (temp) {
          emit(SuccessJoinProject());
        } else {
          emit(ErrorJoinProject());
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineJoinProject());
        } else {
          emit(ErrorJoinProject());
        }
      }
    });
  }
}
