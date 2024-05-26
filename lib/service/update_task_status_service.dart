import 'dart:io';
import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';

Future<bool> updateTaskStatus(int taskId, String taskDescription,
    String taskStatus, int projectId) async {
  Dio dio = Dio();

  try {
    final url = AppUrl.updateTasksStatusUrl(taskId);
    final fullUrl =
        '$url?taskDescription=$taskDescription&taskStatus=$taskStatus&project_id=$projectId';
    final options = getHeader(true);

    print('Full URL: $fullUrl');
    print('Headers: ${options.headers}');

    Response response = await dio.put(
      fullUrl,
      options: options,
    );

    print('Response status: ${response.statusCode}');
    print('Response data: ${response.data}');

    if (response.statusCode == 200) {
      print('Task status updated');
      return true;
    } else {
      print('Update failed with status code: ${response.statusCode}');
      return false;
    }
  } on DioException catch (e) {
    if (e.error is SocketException) {
      print('Offline: ${e.message}');
    } else if (e.response != null) {
      print('Error response: ${e.response!.data} // ${e.response!.statusCode}');
      if (e.response!.statusCode == 403) {
        print('Forbidden: You do not have permission to perform this action.');
      }
    } else {
      print('Dio error: ${e.message}');
    }
    return false;
  } catch (e) {
    print('Unexpected error: $e');
    return false;
  }
}
