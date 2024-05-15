import 'dart:io';
import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/create_new_task.dart';

Future<bool> createNewTask(CreateNewTaskModel createNewTaskModel) async {
  print(createNewTaskModel.toJson());
  try {
    Dio dio = Dio();
    // ProjectsModel ?projectsModel;//!we have to think about this ..
    Response response = await dio.post(
      AppUrl.post_new_task_url,

      // queryParameters: {
      //   'taskName': createNewTaskModel.taskName,
      //   'taskDescription': createNewTaskModel.taskDescription,
      //   'taskStatus': 'NEW',
      //   'project_id': createNewTaskModel.project_id,

      //   },
      // ?taskName=${createNewTaskModel.taskName}&taskDescription=${createNewTaskModel.taskDescription}&taskStatus=NEW&project_id=${createNewTaskModel.project_id}",
//"${AppUrl.post_new_project_url}"+"${createNewTaskModel.project_id=1}",
// 'https://projects-management-system.onrender.com/api/v1/tasks?taskName=do&taskDescription=test&taskStatus=NEW&project_id=5',
      data: createNewTaskModel.toJson(),
      options: getHeader(true),
    );

    if (response.statusCode == 200) {
      print(response.data);
      return true;
    } else {
      print('error in create new task');
      return false;
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
