import 'package:dio/dio.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

// logout(LogoutModel logOutUser) async {
//   Dio dio = Dio();
//   try {
//     Response response = await dio.post(
//       "${AppUrl.logout_url}",
//       data: logOutUser.toMap(),
//       options: getHeader(true),
//     );
//    // config.get<SharedPreferences>().clear();
//     final token = response.data['access_token'];//! we have to change this
//     if (response.statusCode == 200) {
//       print('logout true');
//       if (token is String) {
//         config.get<SharedPreferences>().clear();
//         print("Deleted token ..");
//       }
//       return true;
//     } else {
//       print('logout false');
//       return false;
//     }
//   } on DioException catch (e) {
//     throw e;
//   }
// }

logout() async {
  Dio dio = Dio();
  try {
    Response response =
        await dio.put(AppUrl.logout_url, options: getHeader(true));
    if (response is String) {
      config.get<SharedPreferences>().clear();
      print('logout success,' +
          'token : ${config.get<SharedPreferences>().clear()}');
    } else {
      print('error when logout');
    }
  } on DioException catch (e) {
    print(e);
    throw e;
  }
}
