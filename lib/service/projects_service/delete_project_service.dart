import 'dart:io';
import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';

Future deleteProjectService(int projectId) async {
  Dio dio = Dio();
  String deleteUrl = AppUrl.deleteProjectUrl(projectId);
  final options = getHeader(true);
  print('Delete URL: $deleteUrl');
  print('Headers: ${options.headers}');
  try {
    Response response = await dio.delete(deleteUrl, options: options);
    if (response.statusCode == 200) {
      print(response.data);
      return true;
    } else {
      print('Unexpected status code ((delete)): ${response.statusCode}');
      return false;
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
