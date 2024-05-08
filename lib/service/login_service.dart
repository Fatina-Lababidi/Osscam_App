import 'package:dio/dio.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/model/login_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

logIn(LoginUserModel user) async {
  Dio dio = Dio();
  try {
    Response response = await dio.post(
        "https://projects-management-system.onrender.com/api/v1/auth/authenticate",
        data: user.toMap());
    config.get<SharedPreferences>().setString('token', response.data['token']);
    if (response.statusCode == 200) {
      print('log in true');
      return true;
    } else {
      print('login flase');
      return false;
    }
  } catch (e) {
    throw e;
  }
}
