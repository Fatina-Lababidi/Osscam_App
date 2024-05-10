import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/register_model.dart';
import 'package:osscam/service/register_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<Signup>((event, emit) async {
      emit(SignUpLoading());
      try {
        bool result = await SignUpService(event.user);
        if (result) {
          emit(SignUpSuccess());
        } else {
          emit(SignUpFailed());
        }
      } catch (e) {
        if (e is DioException) {
          if (e.error is SocketException ||
              e.message!.contains('SocketException')) {
            emit(SignUpOffline());
          } else {
            emit(SignUpFailed());
          }
        } else {
          emit(SignUpFailed());
        }
      }
    });
  }
}
