import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/get_bugs_model.dart';
import 'package:osscam/service/get_bugs_service.dart';

part 'get_bugs_by_task_event.dart';
part 'get_bugs_by_task_state.dart';

class GetBugsByTaskBloc extends Bloc<GetBugsByTaskEvent, GetBugsByTaskState> {
  GetBugsByTaskBloc() : super(GetBugsByTaskInitial()) {
    on<GetBugs>((event, emit) async {
      emit(LoadingGetBugs());
      try {
        var temp = await getBugsByTask(event.taskId);
        if (temp is String) {
          emit(FailedGetBugs());
        } else {
          List<GetBugsModel> bugs = List.generate(
              temp.length, (index) => GetBugsModel.fromMap(temp[index]));
          emit(SuccessGetBugs(bugs: bugs));
        }
      } on DioException catch (e) {
        if (e.error is SocketException) {
          emit(OfflineGetBugs());
        } else {
          emit(FailedGetBugs());
        }
      }
    });
  }
}
