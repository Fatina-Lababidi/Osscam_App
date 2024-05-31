// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:osscam/service/base_service.dart';

class ProjectsModel{
  int id;
  String name;
  String description;
  String createDate;
  String status = "NEW";
  // int createdBy;
  ProjectsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createDate,
    required this.status,
    //  required this.createdBy,
  });

  ProjectsModel copyWith({
    int? id,
    String? name,
    String? description,
    String? createDate,
    String? status,
    // int? createdBy,
  }) {
    return ProjectsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createDate: createDate ?? this.createDate,
      status: status ?? this.status,
      //  createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'createDate': createDate,
      'status': status,
      // 'createdBy': createdBy,
    };
  }

  factory ProjectsModel.fromMap(Map<String, dynamic> map) {
    return ProjectsModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      createDate: map['createDate'] as String,
      status: map['status'] as String,
      // createdBy: map['createdBy'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectsModel.fromJson(String source) =>
      ProjectsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectsModel(id: $id, name: $name, description: $description, createDate: $createDate, status: $status)';
    //createdBy: $createdBy
    //  )';
  }

  @override
  bool operator ==(covariant ProjectsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.createDate == createDate &&
        other.status == status;
    //  other.createdBy == createdBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        createDate.hashCode ^
        status.hashCode;
    // createdBy.hashCode;
  }
}
