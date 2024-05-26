import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/create_new_task.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskInitial()) {
    List<CreateNewTaskModel> tasks = [];
    // ? to add new text feild
    // ! remember that you can get better solution with your skill
    on<CreateNewTextFiel>((event, emit) {
      tasks.add(
          CreateNewTaskModel(taskDescription: '', taskStatus: '', project_id: 1));
      emit(NewTextFieldCreated(tasks: tasks));
    });

    // ? to edit prev fake model that we created it to increase list length
    on<SubmitOneTask>((event, emit) {
      tasks.last = event.oneTask;
      emit(OneTaskSubmitd());
      emit(NewTextFieldCreated(tasks: tasks));
      print(tasks);
    });
    // ? this event for send all task to the service layer
    on<SendAllTask>((event, emit) async {
      List<Map> req = [];
      tasks.forEach((element) {
        req.add(element.toMap());
      });
      Response response = await Dio().post("path", data: req);
    });
  }
}
