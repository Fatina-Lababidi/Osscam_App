import 'dart:io';

import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';

Future getBugsByTask(int taskId) async {
  Dio dio = Dio();
  String url = AppUrl.getBugsByTaskIdUrl(taskId);
  try {
    Response response = await dio.get(url, options: getHeader(true));
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      return 'false';
    }
  } on DioException catch (e) {
    if (e.error is SocketException) {
      print('Offline: ${e.message}');
    } else if (e.response != null) {
      print('Error response: ${e.response!.data} // ${e.response!.statusCode}');
      if (e.response!.statusCode == 403) {
        print('Forbidden:${e.message}');
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
