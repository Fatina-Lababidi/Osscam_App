import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/create_new_project_model.dart';
import 'package:osscam/service/create_new_project_service.dart';

part 'create_new_project_event.dart';
part 'create_new_project_state.dart';

class CreateNewProjectBloc
    extends Bloc<CreateNewProjectEvent, CreateNewProjectState> {
  CreateNewProjectBloc() : super(CreateNewProjectInitial()) {
    on<CreateNewProject>((event, emit) async {
      try {
        emit(LoadingCreateProject());
        bool temp = await createNewProject(event.project);
        if (temp) {
          emit(SuccessCreateProject());
        } else {
          emit(ErrorCreateProject());
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineCreateProject());
        } else {
          emit(ErrorCreateProject());
        }
      }
    });
  }
}
