import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/projects_model/get_projects_model.dart';
import 'package:osscam/service/projects_service/get_one_project.dart';

part 'one_project_event.dart';
part 'one_project_state.dart';

class OneProjectBloc extends Bloc<OneProjectEvent, OneProjectState> {
  OneProjectBloc() : super(OneProjectInitial()) {
    on<GetOneProject>((event, emit) async {
      emit(LoadingOneProject());
      try {
        var temp = await getOneProjectService(event.projectId);
        if (temp is String) {
          emit(ErrorOneProject());
        } else {
          ProjectsModel project = ProjectsModel.fromMap(temp);
          emit(SuccessOneProject(projectsModel: project));
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineOneProject());
        } else {
          emit(ErrorOneProject());
        }
      }
    });
  }
}
