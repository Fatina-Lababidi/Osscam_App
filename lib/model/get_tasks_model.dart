import 'dart:convert';

class GetAllTasks {
  int taskId;
  String taskDescription;
  String taskStatus = "NEW";
  bool hasBugs;
  // int project_id;
  GetAllTasks({
    required this.taskId,
    required this.taskDescription,
    required this.taskStatus,
    required this.hasBugs,
    //  required this.project_id,
  });

  GetAllTasks copyWith({
    int? taskId,
    String? taskDescription,
    String? taskStatus,
    bool? hasBugs,
    // int? project_id,
  }) {
    return GetAllTasks(
      taskId: taskId ?? this.taskId,
      taskDescription: taskDescription ?? this.taskDescription,
      taskStatus: taskStatus ?? this.taskStatus,
      hasBugs: hasBugs ?? this.hasBugs,
      //  project_id: project_id ?? this.project_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'taskDescription': taskDescription,
      'taskStatus': taskStatus,
      'hasBugs': hasBugs,
      // 'project_id': project_id,
    };
  }

  factory GetAllTasks.fromMap(Map<String, dynamic> map) {
    return GetAllTasks(
      taskDescription: map['taskDescription'] as String,
      taskStatus: map['taskStatus'] as String,
      //  project_id: map['project_id'] as int,
      taskId: map['taskId'] as int,
      hasBugs: map['hasBugs'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllTasks.fromJson(String source) =>
      GetAllTasks.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetAllTasks( taskId: $taskId,taskDescription: $taskDescription, taskStatus: $taskStatus,hasBugs: $hasBugs)';
    //project_id: $project_id
  }

  @override
  bool operator ==(covariant GetAllTasks other) {
    if (identical(this, other)) return true;

    return other.taskId == taskId &&
        other.taskDescription == taskDescription &&
        other.taskStatus == taskStatus &&
        other.hasBugs == hasBugs;
    //  other.project_id == project_id;
  }

  @override
  int get hashCode {
    return taskId.hashCode ^ taskDescription.hashCode ^ taskStatus.hashCode^ hasBugs.hashCode;
    // project_id.hashCode;
  }
}
