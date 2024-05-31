import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/comment_model/post_comment_model.dart';
import 'package:osscam/service/comments_service/post_comments_service.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsInitial()) {
    on<SendComment>((event, emit) {
      (event, emit) async {
        try {
          emit(LoadingPostComment());
          var temp = await postComments(event.comment);
          if (temp is String) {
            emit(ErrorPostComment());
          } else {
            // PostCommentsModel comment = List.generate(
            //     temp.length, (index) => PostCommentsModel.fromMap(temp[index]));
            PostCommentsModel comment = PostCommentsModel.fromMap(temp);
            emit(SuccessSendingComment(comment: comment));
          }
        } on DioException catch (e) {
          if (e.error is SocketException) {
            emit(OfflinePostComment());
          } else {
            emit(ErrorPostComment());
          }
        }
      };
    });
  }
}
