part of 'comments_bloc.dart';

@immutable
sealed class CommentsEvent {}

class SendComment extends CommentsEvent {
  PostCommentsModel comment;
  SendComment({
    required this.comment,
  });
}