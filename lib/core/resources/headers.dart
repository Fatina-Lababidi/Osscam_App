import 'package:dio/dio.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

getHeader(bool useToken) {
  if (useToken) {
    return Options(headers: {
      'Authorization': 'Bearer ${config.get<SharedPreferences>().getString(
            'token',
          )}',
      "contentType": "application/json",
      "X-Requested-With": "accept: */*"
    });
  } else {
    return Options(
      headers: {
        "contentType": "application/json",
      },
    );
  }
}
