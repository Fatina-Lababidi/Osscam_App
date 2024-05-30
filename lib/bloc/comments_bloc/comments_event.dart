part of 'comments_bloc.dart';

@immutable
sealed class CommentsEvent {}

class SendComment extends CommentsEvent {
  List<PostCommentsModel> comment;
  SendComment({
    required this.comment,
  });
}