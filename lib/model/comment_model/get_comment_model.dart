// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetCommentModel {
  int id;
  String comment;
  String author;
  String createDate;
  String lastModified;
  int createdBy;
  int lastModifiedBy;
  GetCommentModel({
    required this.id,
    required this.comment,
    required this.author,
    required this.createDate,
    required this.lastModified,
    required this.createdBy,
    required this.lastModifiedBy,
  });


  GetCommentModel copyWith({
    int? id,
    String? comment,
    String? author,
    String? createDate,
    String? lastModified,
    int? createdBy,
    int? lastModifiedBy,
  }) {
    return GetCommentModel(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      author: author ?? this.author,
      createDate: createDate ?? this.createDate,
      lastModified: lastModified ?? this.lastModified,
      createdBy: createdBy ?? this.createdBy,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'author': author,
      'createDate': createDate,
      'lastModified': lastModified,
      'createdBy': createdBy,
      'lastModifiedBy': lastModifiedBy,
    };
  }

  factory GetCommentModel.fromMap(Map<String, dynamic> map) {
    return GetCommentModel(
      id: map['id'] as int,
      comment: map['comment'] as String,
      author: map['author'] as String,
      createDate: map['createDate'] as String,
      lastModified: map['lastModified'] as String,
      createdBy: map['createdBy'] as int,
      lastModifiedBy: map['lastModifiedBy'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetCommentModel.fromJson(String source) => GetCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetCommentModel(id: $id, comment: $comment, author: $author, createDate: $createDate, lastModified: $lastModified, createdBy: $createdBy, lastModifiedBy: $lastModifiedBy)';
  }

  @override
  bool operator ==(covariant GetCommentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.comment == comment &&
      other.author == author &&
      other.createDate == createDate &&
      other.lastModified == lastModified &&
      other.createdBy == createdBy &&
      other.lastModifiedBy == lastModifiedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      comment.hashCode ^
      author.hashCode ^
      createDate.hashCode ^
      lastModified.hashCode ^
      createdBy.hashCode ^
      lastModifiedBy.hashCode;
  }
}
