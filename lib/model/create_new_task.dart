// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class CreateNewTaskModelWithColor {
  String taskName;
  String taskDescription;
  String taskStatus = "NEW";
  int project_id;
  Color color;
  CreateNewTaskModelWithColor({
    required this.taskName,
    required this.taskDescription,
    required this.taskStatus,
    required this.project_id,
    required this.color,
  });

  CreateNewTaskModelWithColor copyWith({
    String? taskName,
    String? taskDescription,
    String? taskStatus,
    int? project_id,
    Color? color,
  }) {
    return CreateNewTaskModelWithColor(
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      taskStatus: taskStatus ?? this.taskStatus,
      project_id: project_id ?? this.project_id,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskName': taskName,
      'taskDescription': taskDescription,
      'taskStatus': taskStatus,
      'project_id': project_id,
      'color': color.value,
    };
  }

  factory CreateNewTaskModelWithColor.fromMap(Map<String, dynamic> map) {
    return CreateNewTaskModelWithColor(
      taskName: map['taskName'] as String,
      taskDescription: map['taskDescription'] as String,
      taskStatus: map['taskStatus'] as String,
      project_id: map['project_id'] as int,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateNewTaskModelWithColor.fromJson(String source) => CreateNewTaskModelWithColor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateNewTaskModelWithColor(taskName: $taskName, taskDescription: $taskDescription, taskStatus: $taskStatus, project_id: $project_id, color: $color)';
  }

  @override
  bool operator ==(covariant CreateNewTaskModelWithColor other) {
    if (identical(this, other)) return true;

    return
      other.taskName == taskName &&
      other.taskDescription == taskDescription &&
      other.taskStatus == taskStatus &&
      other.project_id == project_id &&
      other.color == color;
  }

  @override
  int get hashCode {
    return taskName.hashCode ^
      taskDescription.hashCode ^
      taskStatus.hashCode ^
      project_id.hashCode ^
      color.hashCode;
  }
}

class CreateNewTaskModel {
  String taskName;
  String taskDescription;
  String taskStatus = "NEW";
  int project_id;
  CreateNewTaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.taskStatus,
    required this.project_id,
  });

  CreateNewTaskModel copyWith({
    String? taskName,
    String? taskDescription,
    String? taskStatus,
    int? project_id,
  }) {
    return CreateNewTaskModel(
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      taskStatus: taskStatus ?? this.taskStatus,
      project_id: project_id ?? this.project_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskName': taskName,
      'taskDescription': taskDescription,
      'taskStatus': taskStatus,
      'project_id': project_id,
    };
  }

  factory CreateNewTaskModel.fromMap(Map<String, dynamic> map) {
    return CreateNewTaskModel(
      taskName: map['taskName'] as String,
      taskDescription: map['taskDescription'] as String,
      taskStatus: map['taskStatus'] as String,
      project_id: map['project_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateNewTaskModel.fromJson(String source) =>
      CreateNewTaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateNewTaskModel(taskName: $taskName, taskDescription: $taskDescription, taskStatus: $taskStatus, project_id: $project_id)';
  }

  @override
  bool operator ==(covariant CreateNewTaskModel other) {
    if (identical(this, other)) return true;

    return other.taskName == taskName &&
        other.taskDescription == taskDescription &&
        other.taskStatus == taskStatus &&
        other.project_id == project_id;
  }

  @override
  int get hashCode {
    return taskName.hashCode ^
        taskDescription.hashCode ^
        taskStatus.hashCode ^
        project_id.hashCode;
  }
}
