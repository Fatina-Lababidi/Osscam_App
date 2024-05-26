import 'dart:io';

import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/create_new_project_model.dart';

Future createNewProject(CreateNewProjectModel createNewProject) async {
  print(createNewProject.toJson());
  try {
    Dio dio = Dio();
    Response response = await dio.post(
      AppUrl.post_new_project_url,
      data: createNewProject.toJson(),
      options: getHeader(true),
    ); //we can fix the header and call the func

    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      print('error in create new project');
      return 'false';
    }
  } on DioException catch (e) {
    if (e.error is SocketException) {
      print('Offline: ${e.message}');
      throw e;
    } else if (e.response != null && e.response!.statusCode == 403) {
      print('Forbidden: ${e.response!.data}');
      throw e;
    } else {
      print('Dio error: ${e.message}');
      throw e;
    }
  }
}
