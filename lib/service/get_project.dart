import 'package:dio/dio.dart';

import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getProjects() async {
  Dio dio = Dio();

  print(config.get<SharedPreferences>().getString('token'));
  Response response = await dio.get(
    AppUrl.get_projects_url,
       options: getHeader(true)
  );

  if (response.statusCode == 200) {
    dynamic responseData = response.data;
    print(responseData);
    return responseData;
  } else {
    return 'false';
  }
}
