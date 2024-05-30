part of 'comments_bloc.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

class SuccessSendingComment extends CommentsState{
  List<PostCommentsModel> comment;
  SuccessSendingComment({
    required this.comment,
  });
}

class ErrorPostComment extends CommentsState {}

class LoadingPostComment extends CommentsState {}

class OfflinePostComment extends CommentsState {}