import 'dart:io';
import 'package:dio/dio.dart';
import 'package:osscam/core/resources/url.dart';

Future deleteProjectService(int projectId) async {
  Dio dio = Dio();
  try {
    Response response = await dio.delete(AppUrl.deleteProjectUrl(projectId));
    if (response.statusCode == 200) {
      return true;
    } else {
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
