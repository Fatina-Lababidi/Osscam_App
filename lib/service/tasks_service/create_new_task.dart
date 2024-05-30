import 'dart:io';
import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/tasks_model/create_new_task.dart';
 // i have to send a list of create model not only one
 // so we have to change the passing and the data
Future createNewTask(List<CreateNewTaskModel> taskModel) async {
  print('${taskModel}');
  try {
    Dio dio = Dio();
 List<Map<String, dynamic>> jsonTaskList = taskModel.map((task) => task.toMap()).toList();
   //!we have to think about this ..
    Response response = await dio.post(
      AppUrl.post_new_task_url,
      data: jsonTaskList,// !!!!! i have to fix here make it toJson
      options: getHeader(true),
    );

    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      print('error in create new task');
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
