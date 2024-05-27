import 'package:osscam/service/base_service.dart';

class AppUrl {
  static String login_url = "${BaseService().baseUrl}auth/login";
  static String sign_up_url = "${BaseService().baseUrl}auth/register";
  static String logout_url = "${BaseService().baseUrl}auth/logout";
  static String get_projects_url = "${BaseService().baseUrl}projects";
  static String post_new_project_url = '${BaseService().baseUrl}projects';
  static String post_new_task_url = "${BaseService().baseUrl}tasks";

  static String getTaskByProjectUrl(int projectId) {
    return '${BaseService().baseUrl}tasks/tasks-by-project/$projectId';
  }

  static String updateTasksStatusUrl(int taskId) {
    return '${BaseService().baseUrl}tasks/${taskId}';
  }

  static String deleteProjectUrl(int ProjectId) {
    return '${BaseService().baseUrl}projects/${ProjectId}';
  }

  static String joinUserToProjectUrl(int projectId) {
    return '${BaseService().baseUrl}projects/$projectId/new-user-to-project';
  }

  static String getOneProjectUrl(int projectId) {
    return '${BaseService().baseUrl}projects/$projectId';
  }
}
