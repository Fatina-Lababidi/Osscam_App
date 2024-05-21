import 'dart:convert';

class GetAllTasks {
  int taskId;
  String taskDescription;
  String taskStatus = "NEW";
  int project_id;
  GetAllTasks({
   required this.taskId,
    required this.taskDescription,
     required this.taskStatus,
      required this.project_id,
  });

  GetAllTasks copyWith({
    int? taskId,
    String? taskDescription,
    String? taskStatus,
    int? project_id,
  }) {
    return GetAllTasks(
      taskId: taskId ?? this.taskId,
      taskDescription: taskDescription ?? this.taskDescription,
      taskStatus: taskStatus ?? this.taskStatus,
      project_id: project_id ?? this.project_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
       'taskId': taskId,
      'taskDescription': taskDescription,
      'taskStatus': taskStatus,
      'project_id': project_id,
    };
  }

  factory GetAllTasks.fromMap(Map<String, dynamic> map) {
    return GetAllTasks(
      taskDescription: map['taskDescription'] as String,
      taskStatus: map['taskStatus'] as String,
      project_id: map['project_id'] as int, taskId: map['taskId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllTasks.fromJson(String source) => GetAllTasks.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetAllTasks( taskId: $taskId,taskDescription: $taskDescription, taskStatus: $taskStatus, project_id: $project_id)';
  }

  @override
  bool operator ==(covariant GetAllTasks other) {
    if (identical(this, other)) return true;
  
    return other.taskId == taskId &&
      other.taskDescription == taskDescription &&
      other.taskStatus == taskStatus &&
      other.project_id == project_id;
  }

  @override
  int get hashCode {
    return taskId.hashCode ^ 
      taskDescription.hashCode ^
      taskStatus.hashCode ^
      project_id.hashCode;
  }
}
