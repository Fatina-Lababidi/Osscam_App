import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/projects_model/create_new_project_model.dart';
import 'package:osscam/model/projects_model/get_projects_model.dart';
import 'package:osscam/service/projects_service/create_new_project_service.dart';

part 'create_new_project_event.dart';
part 'create_new_project_state.dart';

class CreateNewProjectBloc
    extends Bloc<CreateNewProjectEvent, CreateNewProjectState> {
  CreateNewProjectBloc() : super(CreateNewProjectInitial()) {
    on<CreateNewProject>((event, emit) async {
      try {
        emit(LoadingCreateProject());
        var temp = await createNewProject(event.project);
        if (temp is String) {
          emit(ErrorCreateProject());
        } else {
          ProjectsModel project = ProjectsModel.fromMap(temp);
          emit(SuccessCreateProject(project: project));
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
