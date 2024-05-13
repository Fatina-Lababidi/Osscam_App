// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateNewProjectModel {
  String projectName;
  String projectDescription;
  String projectStatus = "NEW";
  CreateNewProjectModel({
    required this.projectName,
    required this.projectDescription,
    required this.projectStatus,
  });

  CreateNewProjectModel copyWith({
    String? projectName,
    String? projectDescription,
    String? projectStatus,
  }) {
    return CreateNewProjectModel(
      projectName: projectName ?? this.projectName,
      projectDescription: projectDescription ?? this.projectDescription,
      projectStatus: projectStatus ?? this.projectStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'projectName': projectName,
      'projectDescription': projectDescription,
      'projectStatus': projectStatus,
    };
  }

  factory CreateNewProjectModel.fromMap(Map<String, dynamic> map) {
    return CreateNewProjectModel(
      projectName: map['projectName'] as String,
      projectDescription: map['projectDescription'] as String,
      projectStatus: map['projectStatus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateNewProjectModel.fromJson(String source) => CreateNewProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CreateNewProjectModel(projectName: $projectName, projectDescription: $projectDescription, projectStatus: $projectStatus)';

  @override
  bool operator ==(covariant CreateNewProjectModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.projectName == projectName &&
      other.projectDescription == projectDescription &&
      other.projectStatus == projectStatus;
  }

  @override
  int get hashCode => projectName.hashCode ^ projectDescription.hashCode ^ projectStatus.hashCode;
}
