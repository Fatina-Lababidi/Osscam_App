import 'package:dio/dio.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/logout_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

logout(LogoutModel logOutUser) async {
  Dio dio = Dio();
  try {
    Response response = await dio.post(
        "${AppUrl().logout_url}",
        data: logOutUser.toMap());
    config.get<SharedPreferences>().getString('token');
    final token = response.data['token'];
    if (response.statusCode == 200) {
      print('logout true');
      print(token);
      if(token is String){
        // config.get<SharedPreferences>().remove('token');
        print("Deleted token ..");
      }
      return true;
    } else {
      print('logout false');
      return false;
    }
  }on DioException catch (e) {
    throw e;
  }
}

Future<void> clearUserToken() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('user_token');
}
