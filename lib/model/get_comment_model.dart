// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetCommentModel {
  int id;
  String comment;
  String author;
  GetCommentModel({
    required this.id,
    required this.comment,
    required this.author,
  });

  GetCommentModel copyWith({
    int? id,
    String? comment,
    String? author,
  }) {
    return GetCommentModel(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'author': author,
    };
  }

  factory GetCommentModel.fromMap(Map<String, dynamic> map) {
    return GetCommentModel(
      id: map['id'] as int,
      comment: map['comment'] as String,
      author: map['author'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetCommentModel.fromJson(String source) => GetCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetCommentModel(id: $id, comment: $comment, author: $author)';

  @override
  bool operator ==(covariant GetCommentModel other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.comment == comment &&
      other.author == author;
  }

  @override
  int get hashCode => id.hashCode ^ comment.hashCode ^ author.hashCode;
}
