import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/add_task/add_task_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/tasks_model/create_new_task.dart';
import 'package:osscam/pages/handle_exception_pages/error_page.dart';
import 'package:osscam/pages/projects_pages/getOneProject_page.dart';
import 'package:osscam/pages/handle_exception_pages/offline_page.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:page_transition/page_transition.dart';

class CreateNewTaskPage extends StatefulWidget {
  CreateNewTaskPage({super.key, required this.id});
  final int id;
  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  // List<String> textList = [''];
//  CreateNewTaskModel oneTask = CreateNewTaskModel(taskDescription: '', taskStatus: "NEW", project_id: 2);
  // List<CreateNewTaskModel> tasksList = [
  //   CreateNewTaskModel(taskDescription: '', taskStatus: "NEW", project_id: 2)
  // ];
  //TextEditingController taskDescController = TextEditingController();

  final TextEditingController _textController = TextEditingController();
  List<CreateNewTaskModel> tasksList = [];

  bool showTextField = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void addNewTask() {
    setState(() {
      tasksList.insert(
          0,
          CreateNewTaskModel(
              taskDescription: _textController.text,
              taskStatus: "NEW",
              project_id: widget.id));
      // tasksList.add(CreateNewTaskModel(
      //     taskDescription: _textController.text,
      //     taskStatus: "NEW",
      //     project_id: widget.id));
      _textController.clear();
      showTextField = false;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasksList.removeAt(index);
    });
  }

  // ValueNotifier<ListOf<ProjectsModel>> project =
  //     ValueNotifier(ListOf(project: []));
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final formCreateKey = GlobalKey<FormState>();
    // CreateNewTaskModel oneTask = CreateNewTaskModel(
    //     taskDescription: '', taskStatus: "NEW", project_id: widget.id);
    // List<CreateNewTaskModel> tasksList = [oneTask];
    return BlocProvider(
      create: (context) => AddTaskBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: BlocListener<AddTaskBloc, AddTaskState>(
              listener: (context, state) {
                if (state is SuccessSendingAllTask) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      content: Text(
                        'Successful creating new tasks ...',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: AppColors.cardGreenColor,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OneProjectPage(
                            ProjectId: widget.id,
                          ),
                          type: PageTransitionType.fade));
                } else if (State is OfflineCreateTask) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    content: Text(
                      'Offline,please try later...',
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: AppColors.dropTextColor,
                    duration: Duration(seconds: 2),
                  ));
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OfflinePage(
                              previousPage: CreateNewTaskPage(
                            id: widget.id,
                          )),
                          type: PageTransitionType.fade));
                } else if (state is ErrorCreateTask) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    content: Text(
                      'Error,please try again...',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: AppColors.deleteCardColor,
                    duration: Duration(seconds: 2),
                  ));
                  Navigator.push(
                      context,
                      PageTransition(
                          child: ErrorPage(
                              previousPage: CreateNewTaskPage(
                            id: widget.id,
                          )),
                          type: PageTransitionType.fade));
                }
              },
              child: Form(
                key: formCreateKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Image(
                          alignment: Alignment.topLeft,
                          width: screenWidth,
                          height: screenHeight * 0.12,
                          image: const AssetImage(
                            AppImages.osscamLogo,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.09),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Tasks',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textCreateColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        if (!showTextField)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(),
                              Container(
                                width: screenWidth * 0.65, //234,
                                height: screenHeight * 0.1, //70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.cardPurpleColor,
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01,
                                      horizontal: screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: SizedBox(
                                    width: screenWidth * 0.4, //215.28,
                                    height: screenHeight * 0.5, // 50,
                                    child: TextField(
                                      controller: _textController,
                                      maxLines: 1,
                                      cursorColor: AppColors.primaryColor,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Text',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    if (_textController.text.isNotEmpty) {
                                      addNewTask();
                                    }
                                  },
                                  icon: Icon(Icons.add_circle,
                                      color: Colors.white,
                                      size: screenHeight * 0.05 //35,
                                      ))
                            ],
                          ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        SizedBox(
                          width: screenWidth, //234,
                          height: screenHeight * 0.5,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: tasksList.length,
                            itemBuilder: (context, index) {
                              final task = tasksList[index];
                              return Dismissible(
                                key: Key(task.taskDescription),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) {
                                  deleteTask(index);
                                },
                                background: Container(
                                  margin: EdgeInsets.only(
                                    right: screenWidth * 0.2,
                                    left: screenWidth * 0.07,
                                    top: screenHeight * 0.01,
                                    bottom: screenHeight * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.deleteCardColor,
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: screenWidth * 0.2,
                                    left: screenWidth * 0.07,
                                    top: screenHeight * 0.01,
                                    bottom: screenHeight * 0.01,
                                  ),
                                  width: screenWidth, //234,
                                  height: screenHeight * 0.11,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.cardPurpleColor,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2, color: Colors.black)
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(task.taskDescription),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.08,
                        ),
                        BlocBuilder<AddTaskBloc, AddTaskState>(
                          builder: (context, state) {
                            if (state is AddTaskInitial) {
                              return ButtonApp(
                                textColor: AppColors.primaryColor,
                                color: AppColors.buttonColor,
                                text: 'Create',
                                onTap: () {
                                  if (formCreateKey.currentState!.validate()) {
                                    // List<String> filteredList = textList
                                    //     .where((element) => element.isNotEmpty)
                                    //     .toList();
                                    List<CreateNewTaskModel> filteredList =
                                        tasksList
                                            .where((e) =>
                                                e.taskDescription.isNotEmpty)
                                            .toList();

                                    print('Filtered list: $filteredList');
                                    context
                                        .read<AddTaskBloc>()
                                        .add(SendAllTask(tasks: filteredList));

                                    // context.read<AddTaskBloc>().add(
                                    //     SubmitOneTask(
                                    //         oneTask: CreateNewTaskModel(
                                    //             taskDescription:
                                    //                 taskDescController.text,
                                    //             taskStatus: "NEW",
                                    //             project_id: 2)));
                                  }
                                },
                              );
                            } else {
                              return Center(
                                child: const CircularProgressIndicator(
                                  color: AppColors.continerColor,
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
