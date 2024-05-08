import 'package:dio/dio.dart';
import 'package:osscam/model/register_model.dart';


Future SignUpService(SignupUserModel userModel) async {
  Dio dio = Dio();
  try {
    Response response = await dio.post(
      "https://projects-management-system.onrender.com/api/v1/auth/register",
      data: userModel.toMap(),
    );
    if (response.statusCode == 200) {
      print(response.data);
      final token = response.data['token'];
      return true;
    } else {
      print('faild register');
      return false;
      // throw DioError(response: response,error: 'faild');
    }
  } catch (e) {
    throw e;
  }
  // config.get<SharedPreferences>().setString('token', response.data['token']);
  // if (response.statusCode == 200) {
  //   return true;
  // } else {
  //   return false;
  // }
}
