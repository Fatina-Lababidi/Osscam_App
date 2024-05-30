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
        var temp = await joinProjectService(event.projectId);
        if (temp is String) {
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
