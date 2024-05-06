import 'package:dio/dio.dart';
import 'package:osscam/config.dart';
import 'package:osscam/model/login_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

logIn(LoginUserModel user)async{
  Dio dio=Dio();
  Response response = await dio.post(
    "https://projects-management-system.onrender.com/api/v1/auth/authenticate",
    data: user.toMap()
  );
  config.get<SharedPreferences>().setString('token',response.data['token']);
  if(response.statusCode == 200){
    return true;
  }else{
    return false;
  }
}