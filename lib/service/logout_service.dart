import 'package:dio/dio.dart';
import 'package:osscam/core/resources/headers.dart';
import 'package:osscam/core/resources/url.dart';

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

Future logout() async {
  Dio dio = Dio();
  try {
    Response response =
        await dio.put(AppUrl.logout_url, options: getHeader(true));
    if (response.statusCode == 200) {
      //! here we make it clear or remove just token ?
      //  config.get<SharedPreferences>().remove('token');
      //   config.get<SharedPreferences>().clear();
      //   print('logout success,' +
      //       'token : ${config.get<SharedPreferences>().clear()}');
      return response.data;
    } else {
      print('error when logout');
      return false;
    }
  } on DioException catch (e) {
    print(e);
    throw e;
  }
}
