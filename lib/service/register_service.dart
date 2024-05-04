
import 'package:dio/dio.dart';
import 'package:osscam/config.dart';
import 'package:osscam/model/register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

SignUp(SignupUserModel userModel)async{
  Dio dio=Dio();
  Response response = await dio.post(
    "http://localhost:3010/api/v1/auth/register",
    data: userModel.toMap()
  );
  config.get<SharedPreferences>().setString('token',response.data['token']);
  if(response.statusCode == 202){
    return true;
  }else{
    return false;
  }
}