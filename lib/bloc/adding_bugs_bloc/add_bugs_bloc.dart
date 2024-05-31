import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/bugs_model/add_bugs_model.dart';
import 'package:osscam/service/bugs_service/add_bugs_service.dart';

part 'add_bugs_event.dart';
part 'add_bugs_state.dart';

class AddBugsBloc extends Bloc<AddBugsEvent, AddBugsState> {
  AddBugsBloc() : super(AddBugsInitial()) {
    on<AddBug>((event, emit) async {
      emit(LoadingAddBug());
      try {
        var temp = await addNewBugs(event.bug);
        if (temp ) {
          emit(SuccessAddBug());
        } else {
          emit(ErrorAddBug());
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineAddBug());
        } else {
          emit(ErrorAddBug());
        }
      }
    });
  }
}
