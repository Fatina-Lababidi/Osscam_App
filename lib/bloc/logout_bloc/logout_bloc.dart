import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/logout_model.dart';
import 'package:osscam/service/logout_service.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<Logout>((event, emit) async {
      emit(Loading());
      try {
        bool result = await logout(event.logOutModel);
        if (result) {
          emit(Success());
        } else {
          emit(Failed());
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(Offline());
        } else {
          emit(Failed());
        }
      }
    });
  }
}
