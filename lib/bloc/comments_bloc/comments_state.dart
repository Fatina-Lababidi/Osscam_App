part of 'comments_bloc.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

// ignore: must_be_immutable
class SuccessSendingComment extends CommentsState{
  
}

class ErrorPostComment extends CommentsState {}

class LoadingPostComment extends CommentsState {}

class OfflinePostComment extends CommentsState {}