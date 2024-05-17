import 'package:dio/dio.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:osscam/model/login_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

Future logIn(LoginUserModel user) async {
  Dio dio = Dio();
  try {
    Response response = await dio.post(
      "${AppUrl.login_url}",
      data: user.toMap(),
     options: getHeader(false),
    );
print(';;');

    if (response.statusCode == 200) {
      print('login true');
      config
          .get<SharedPreferences>()
          .setString('token', response.data["access_token"]);
      return true;
    } else {
      print('login false');
      return false;
    }
  } on DioException catch (e) {
    if (e.error is SocketException) {
      print('Offline: ${e.message}');
      throw e;
    } else if (e.response != null && e.response!.statusCode == 403) {
      print('Forbidden: ${e.response!.data}');
      throw e;
    } else {
      print('Dio error: ${e.message}');
      throw e;
    }
  }
}






// Future<void> fetchData(String token) async {
//  Dio dio = Dio();
//   Response response = await dio.post(
//     "${AppUrl().login_url}",
//   options: Options(
//     headers:{'Authorization':'token $token'}
//   ),
    
//   );

//   if (response.statusCode == 200) {
//     final data = json.decode(response.data['token']);
//     // Process the data (e.g., update UI or store it in a state variable)
//     print(data);
//   } else {
//     print('Error fetching data: ${response.statusCode}');
//   }
// }
