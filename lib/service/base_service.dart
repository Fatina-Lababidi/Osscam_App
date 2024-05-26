import 'package:dio/dio.dart';

 class BaseService {
  Dio dio = Dio();
  final String baseUrl = 'https://projects-management-system.onrender.com/api/v1/';
}

class ResutlModel {}

class ErrorModel extends ResutlModel {
  String message;
  ErrorModel({
    required this.message,
  });
}

class ExceptionModel extends ResutlModel {
  String message;
  ExceptionModel({
    required this.message,
  });
}

class ListOf<T extends ResutlModel> extends ResutlModel {
  List<T> project;
  ListOf({
    required this.project,
  });
  
}
