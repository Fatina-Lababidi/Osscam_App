part of 'comments_bloc.dart';

@immutable
sealed class CommentsEvent {}

// ignore: must_be_immutable
class SendComment extends CommentsEvent {
  PostCommentsModel comment;
  SendComment({
    required this.comment,
  });
}