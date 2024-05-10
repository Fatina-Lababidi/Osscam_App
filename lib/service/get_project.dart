import 'package:dio/dio.dart';
import 'package:osscam/core/resources/url.dart';

Future getProjects() async {
  Dio dio = Dio();
  try {
    Response response = await dio.get(AppUrl.get_projects_url);
    print(response.data);
    if (response.statusCode == 200) {
      List responseData = response.data;
      return responseData;
    } else {
      return 'false';
    }
  } catch (e) {
    throw e;
  }
}
