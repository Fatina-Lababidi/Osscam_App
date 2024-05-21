import 'package:osscam/service/base_service.dart';

class AppUrl {
  static String login_url = "${BaseService().baseUrl}auth/login";
  static String sign_up_url = "${BaseService().baseUrl}auth/register";
  static String logout_url = "${BaseService().baseUrl}auth/logout";
  static String get_projects_url = "${BaseService().baseUrl}projects";
  static String post_new_project_url = '${BaseService().baseUrl}projects';
  static String post_new_task_url = "${BaseService().baseUrl}tasks";
}
