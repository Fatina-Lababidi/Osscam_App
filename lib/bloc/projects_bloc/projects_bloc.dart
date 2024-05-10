import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/get_projects_model.dart';
import 'package:osscam/service/get_project.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(ProjectsInitial()) {
    on<GetProjects>((event, emit) async {
      try {
        emit(LoadingGetProjects());
        final dynamic temp = await getProjects();
        if (temp is String) {
          emit(ErrorGetProjects());
        } else {
          List<ProjectsModel> projectsM = List.generate(
              temp.length, (index) => ProjectsModel.fromMap(temp[index]));
          emit(SuccessGetProjects(projects: projectsM));
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineOnGetProjects());
        } else {
          emit(ErrorGetProjects());
        }
      }
    });
  }
}
