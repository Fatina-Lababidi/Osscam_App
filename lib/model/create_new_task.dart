// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
class CreateNewTaskModel {
  String taskDescription;
  String taskStatus = "NEW";
  int project_id;
  CreateNewTaskModel({
    required this.taskDescription,
    required this.taskStatus,
    required this.project_id,
  });

  CreateNewTaskModel copyWith({
    String? taskDescription,
    String? taskStatus,
    int? project_id,
  }) {
    return CreateNewTaskModel(
      taskDescription: taskDescription ?? this.taskDescription,
      taskStatus: taskStatus ?? this.taskStatus,
      project_id: project_id ?? this.project_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskDescription': taskDescription,
      'taskStatus': taskStatus,
      'project_id': project_id,
    };
  }

  factory CreateNewTaskModel.fromMap(Map<String, dynamic> map) {
    return CreateNewTaskModel(
      taskDescription: map['taskDescription'] as String,
      taskStatus: map['taskStatus'] as String,
      project_id: map['project_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateNewTaskModel.fromJson(String source) =>
      CreateNewTaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CreateNewTaskModel(taskDescription: $taskDescription, taskStatus: $taskStatus, project_id: $project_id)';

  @override
  bool operator ==(covariant CreateNewTaskModel other) {
    if (identical(this, other)) return true;

    return other.taskDescription == taskDescription &&
        other.taskStatus == taskStatus &&
        other.project_id == project_id;
  }

  @override
  int get hashCode =>
      taskDescription.hashCode ^ taskStatus.hashCode ^ project_id.hashCode;
}
