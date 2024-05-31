import 'dart:io';

import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/bugs_model/add_bugs_model.dart';

Future addNewBugs(AddingBugsModel addingBugsModel) async {
  Dio dio = Dio();
  final String addBugsUrl = AppUrl.addNewBugsUrl;
  try {
    Response response = await dio.post(addBugsUrl,
        data: addingBugsModel.toJson(), options: getHeader(true));
    if (response.statusCode == 200) {
      print('done adding bug');
      return true; //response.data;
    } else {
      print('error when adding bug');
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
