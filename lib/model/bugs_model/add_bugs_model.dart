// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddingBugsModel {
  String title;
  String description;
  int priority;
  int taskId;
  AddingBugsModel({
    required this.title,
    required this.description,
    required this.priority,
    required this.taskId,
  });

  AddingBugsModel copyWith({
    String? title,
    String? description,
    int? priority,
    int? taskId,
  }) {
    return AddingBugsModel(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      taskId: taskId ?? this.taskId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'priority': priority,
      'taskId': taskId,
    };
  }

  factory AddingBugsModel.fromMap(Map<String, dynamic> map) {
    return AddingBugsModel(
      title: map['title'] as String,
      description: map['description'] as String,
      priority: map['priority'] as int,
      taskId: map['taskId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddingBugsModel.fromJson(String source) => AddingBugsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddingBugsModel(title: $title, description: $description, priority: $priority, taskId: $taskId)';
  }

  @override
  bool operator ==(covariant AddingBugsModel other) {
    if (identical(this, other)) return true;

    return
      other.title == title &&
      other.description == description &&
      other.priority == priority &&
      other.taskId == taskId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      priority.hashCode ^
      taskId.hashCode;
  }
}
