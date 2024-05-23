import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/service/logout_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<Logout>((event, emit) async {
      emit(LogOutLoading());
      try {
        var result = await logout();
        if (result is String) {
          config.get<SharedPreferences>().remove('token');
          config.get<SharedPreferences>().clear();
          print('logout success,' +
              'token : ${config.get<SharedPreferences>().clear()}');
          emit(LogOutSuccess(message: result));
        } else {
          emit(LogOutFailed());
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(LogOutOffline());
        } else {
          emit(LogOutFailed());
        }
      }
    });
  }
}
