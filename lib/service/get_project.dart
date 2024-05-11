import 'package:dio/dio.dart';
import 'package:osscam/bloc/projects_bloc/projects_bloc.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/get_projects_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getProjects(ProjectsModel projectsM ) async {
  Dio dio = Dio();

      print(config.get<SharedPreferences>().getString('token'));
    Response response = await dio.get("${AppUrl.get_projects_url}",options: getHeader(true));

    if (response.statusCode == 200) {
      final responseData = response.data;
      print(responseData);
    } else {
      print(response.data['message']);
       print(response);
      List<ProjectsModel> projects = List.generate(response.data['projects'].length,
      (index) => ProjectsModel.fromMap(response.data['projects'][index] ));
  print(projects);
  return projects;
    }
 
}
