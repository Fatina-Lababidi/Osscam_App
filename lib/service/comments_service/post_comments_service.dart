import 'dart:io';

import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/bugs_model/add_bugs_model.dart';
import 'package:osscam/model/comment_model/post_comment_model.dart';

Future postComments(PostCommentsModel postCommentsModel) async {
  Dio dio = Dio();
  final String postCommentsUrl = AppUrl.post_new_comment_url;
  try {
    Response response = await dio.post(postCommentsUrl,
        data: postCommentsModel.toJson(), options: getHeader(true));
    if (response.statusCode == 200) {
      print('success post comment');
      return true; //response.data;
    } else {
      print('error when posting comment');
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
