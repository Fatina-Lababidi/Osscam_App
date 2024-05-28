// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:osscam/model/get_comment_model.dart';

class GetBugsModel {
  int id;
  String title;
  int taskId;
  bool hasComments;
  String description;
  List<GetCommentModel> comments;
  GetBugsModel({
    required this.id,
    required this.title,
    required this.taskId,
    required this.hasComments,
    required this.description,
    required this.comments,
  });



  GetBugsModel copyWith({
    int? id,
    String? title,
    int? taskId,
    bool? hasComments,
    String? description,
    List<GetCommentModel>? comments,
  }) {
    return GetBugsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      taskId: taskId ?? this.taskId,
      hasComments: hasComments ?? this.hasComments,
      description: description ?? this.description,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'taskId': taskId,
      'hasComments': hasComments,
      'description': description,
      'comments': comments.map((x) => x.toMap()).toList(),
    };
  }

  factory GetBugsModel.fromMap(Map<String, dynamic> map) {
    return GetBugsModel(
      id: map['id'] as int,
      title: map['title'] as String,
      taskId: map['taskId'] as int,
      hasComments: map['hasComments'] as bool,
      description: map['description'] as String,
      comments: List<GetCommentModel>.from((map['comments'] as List).map<GetCommentModel>((x) => GetCommentModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetBugsModel.fromJson(String source) => GetBugsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetBugsModel(id: $id, title: $title, taskId: $taskId, hasComments: $hasComments, description: $description, comments: $comments)';
  }

  @override
  bool operator ==(covariant GetBugsModel other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.title == title &&
      other.taskId == taskId &&
      other.hasComments == hasComments &&
      other.description == description &&
      listEquals(other.comments, comments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      taskId.hashCode ^
      hasComments.hashCode ^
      description.hashCode ^
      comments.hashCode;
  }
}
