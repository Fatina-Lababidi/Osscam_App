import 'package:dio/dio.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/register_model.dart';


Future SignUpService(SignupUserModel userModel) async {
  Dio dio = Dio();
  try {
    Response response = await dio.post(
      "${AppUrl().sign_up_url}",
      data: userModel.toMap(),
    );
    
    if (response.statusCode == 200) {
      print(response.data);
      final token = response.data['token'];
      print(token);
      return true;
    } else {
      print('Error fetching data: ${response.statusCode}');
      return false;
    }
  }on DioException catch (e) {
    print(e);
    throw e;
  }
  // config.get<SharedPreferences>().setString('token', response.data['token']);
  // if (response.statusCode == 200) {
  //   return true;
  // } else {
  //   return false;
  // }
}
