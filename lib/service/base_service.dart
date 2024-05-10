import 'package:dio/dio.dart';

abstract class BaseService {
  Dio dio = Dio();
  final String baseUrl = '';
}
