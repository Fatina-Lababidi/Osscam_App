// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostCommentsModel {
  String comment;
  int bugId;
  PostCommentsModel({
    required this.comment,
    required this.bugId,
  });

  PostCommentsModel copyWith({
    String? comment,
    int? bugId,
  }) {
    return PostCommentsModel(
      comment: comment ?? this.comment,
      bugId: bugId ?? this.bugId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'bugId': bugId,
    };
  }

  factory PostCommentsModel.fromMap(Map<String, dynamic> map) {
    return PostCommentsModel(
      comment: map['comment'] as String,
      bugId: map['bugId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostCommentsModel.fromJson(String source) => PostCommentsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PostCommentsModel(comment: $comment, bugId: $bugId)';

  @override
  bool operator ==(covariant PostCommentsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.comment == comment &&
      other.bugId == bugId;
  }

  @override
  int get hashCode => comment.hashCode ^ bugId.hashCode;
}
