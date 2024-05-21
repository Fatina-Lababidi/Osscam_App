import 'dart:convert';

import 'package:flutter/material.dart';

class CreateNewTaskModelWithColor {

  String taskDescription;
  String taskStatus = "NEW";
  int project_id;
  Color? color;
  CreateNewTaskModelWithColor({

    required this.taskDescription,
    required this.taskStatus,
    required this.project_id,
     this.color,
  });

  CreateNewTaskModelWithColor copyWith({

    String? taskDescription,
    String? taskStatus,
    int? project_id,
    Color? color,
  }) {
    return CreateNewTaskModelWithColor(

      taskDescription: taskDescription ?? this.taskDescription,
      taskStatus: taskStatus ?? this.taskStatus,
      project_id: project_id ?? this.project_id,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
 
      'taskDescription': taskDescription,
      'taskStatus': taskStatus,
      'project_id': project_id,
      'color': color?.value,
    };
  }

  factory CreateNewTaskModelWithColor.fromMap(Map<String, dynamic> map) {
    return CreateNewTaskModelWithColor(

      taskDescription: map['taskDescription'] as String,
      taskStatus: map['taskStatus'] as String,
      project_id: map['project_id'] as int,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateNewTaskModelWithColor.fromJson(String source) =>
      CreateNewTaskModelWithColor.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateNewTaskModelWithColor( taskDescription: $taskDescription, taskStatus: $taskStatus, project_id: $project_id, color: $color)';
  }

  @override
  bool operator ==(covariant CreateNewTaskModelWithColor other) {
    if (identical(this, other)) return true;

    return 
        other.taskDescription == taskDescription &&
        other.taskStatus == taskStatus &&
        other.project_id == project_id &&
        other.color == color;
  }

  @override
  int get hashCode {
    return 
        taskDescription.hashCode ^
        taskStatus.hashCode ^
        project_id.hashCode ^
        color.hashCode;
  }
}
