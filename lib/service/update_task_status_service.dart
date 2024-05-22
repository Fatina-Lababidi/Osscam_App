import 'dart:io';

import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';

Future updateTaskStatus(int taskId, String taskDescription, String taskStatus,
    int project_id) async {
  // try {
  Dio dio = Dio();
  final url = AppUrl.updateTasksStatusUrl(taskId);
  Response response = await dio.put(
    url,
    data: {
      "taskDescription": taskDescription,
      "taskStatus": taskStatus,
      "project_id": project_id,
    },
    options: getHeader(true),
  );
  print(response);
  if (response.statusCode == 200) {
    print('task status updated');
    return true;
  } else {
    return false;
  }
  // } on DioException catch (e) {
  //   if (e.error is SocketException) {
  //     print('Offline: ${e.message}');
  //     throw e;
  //   } else if (e.response != null && e.response!.statusCode == 403) {
  //     print('Forbidden: ${e.response!.data}');
  //     throw e;
  //   } else {
  //     print('Dio error: ${e.message}');
  //     throw e;
  //   }
  // }
}
