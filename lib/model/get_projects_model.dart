// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProjectsModel {
  int id;
  String name;
  String description;
  String createDate;
  String lastModified;
  int createdBy;
  int lastModifiedBy;
  ProjectsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createDate,
    required this.lastModified,
    required this.createdBy,
    required this.lastModifiedBy,
  });

  ProjectsModel copyWith({
    int? id,
    String? name,
    String? description,
    String? createDate,
    String? lastModified,
    int? createdBy,
    int? lastModifiedBy,
  }) {
    return ProjectsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createDate: createDate ?? this.createDate,
      lastModified: lastModified ?? this.lastModified,
      createdBy: createdBy ?? this.createdBy,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'createDate': createDate,
      'lastModified': lastModified,
      'createdBy': createdBy,
      'lastModifiedBy': lastModifiedBy,
    };
  }

  factory ProjectsModel.fromMap(Map<String, dynamic> map) {
    return ProjectsModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      createDate: map['createDate'] as String,
      lastModified: map['lastModified'] as String,
      createdBy: map['createdBy'] as int,
      lastModifiedBy: map['lastModifiedBy'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectsModel.fromJson(String source) => ProjectsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectsModel(id: $id, name: $name, description: $description, createDate: $createDate, lastModified: $lastModified, createdBy: $createdBy, lastModifiedBy: $lastModifiedBy)';
  }

  @override
  bool operator ==(covariant ProjectsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.createDate == createDate &&
      other.lastModified == lastModified &&
      other.createdBy == createdBy &&
      other.lastModifiedBy == lastModifiedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      createDate.hashCode ^
      lastModified.hashCode ^
      createdBy.hashCode ^
      lastModifiedBy.hashCode;
  }
}
