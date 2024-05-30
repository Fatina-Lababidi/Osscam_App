import 'package:dio/dio.dart';

 class BaseService {
  Dio dio = Dio();
  final String baseUrl = 'https://projects-management-system.onrender.com/api/v1/';
}
