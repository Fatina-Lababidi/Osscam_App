import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/tasks_model/get_tasks_model.dart';

Future fetchTasksByProjectId(int projectId) async {
  final url = AppUrl.getTaskByProjectUrl(projectId);
  Dio dio = Dio();
  final response = await dio.get(url, options: getHeader(true));

  if (response.statusCode == 200) {
    dynamic responseData = response.data;
      List<GetAllTasks> tasks = List.generate(
             responseData .length, (index) => GetAllTasks.fromMap(responseData[index]));
    print(responseData);
    return tasks;
   // response.data;
  } else {
    return 'false';
  }
}
