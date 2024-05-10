import 'package:dio/dio.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future SignUpService(SignupUserModel userModel) async {
  Dio dio = Dio();
  try {
    Response response = await dio.post(
      "${AppUrl.sign_up_url}",
      data: userModel.toMap(),
      options: getHeader(false),
    );

    if (response.statusCode == 200) {
      config
          .get<SharedPreferences>()
          .setString('token', response.data["token"]);
      print(response.data["token"]);
      return true;
    } else {
      print('Error fetching data: ${response.statusCode}');
      return false;
    }
  } on DioException catch (e) {
    print(e);
    throw e;
  }
}
