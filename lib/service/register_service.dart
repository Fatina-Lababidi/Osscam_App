import 'package:dio/dio.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/model/register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future SignUpService(SignupUserModel userModel) async {
  Dio dio = Dio();
  Response response =
      await dio.post("https://projects-management-system.onrender.com/api/v1/auth/register",
          data: userModel.toMap(), 
);
  if (response.statusCode == 200) {
    print(response.data);
    final token =response.data['token'];
    return token;
  } else {
   print('faild register');
   // throw DioError(response: response,error: 'faild');
  }
  // config.get<SharedPreferences>().setString('token', response.data['token']);
  // if (response.statusCode == 200) {
  //   return true;
  // } else {
  //   return false;
  // }
}
