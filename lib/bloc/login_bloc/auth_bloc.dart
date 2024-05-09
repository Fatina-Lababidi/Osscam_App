import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/login_user_model.dart';
import 'package:osscam/service/login_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<Login>((event, emit) async {
      emit(Loading());
      try {
        bool result = await logIn(event.usermodel);
        if (result) {
          emit(Success());
        } else {
          emit(Failed());
        }
      } on DioException catch (e) {
        if (e.error is SocketException ) {
          emit(Offline());
        } else {
          emit(Failed());
        }
      } catch (_) {
        emit(Failed());
      }
    });
  }
}

