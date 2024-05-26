import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/add_task/add_task_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/create_new_task.dart';
import 'package:osscam/pages/error_page.dart';
import 'package:osscam/pages/getOneProject_page.dart';
import 'package:osscam/pages/offline_page.dart';
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
      tasksList.add(CreateNewTaskModel(
          taskDescription: _textController.text,
          taskStatus: "NEW",
          project_id: widget.id));
      _textController.clear();
      showTextField = false;
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
                      SnackBar(content: Text('Success creating')));
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OneProjectPage(
                            ProjectId: widget.id,
                          ),
                          type: PageTransitionType.fade));
                }
                else if (State is OfflineCreateTask) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(label: "", onPressed: () {}),
                      content: const Text("Offline while creating"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OfflinePage(
                              previousPage: CreateNewTaskPage(
                            id: widget.id,
                          )),
                          type: PageTransitionType.fade));
                } else if (state is ErrorCreateTask) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(label: "", onPressed: () {}),
                      content: const Text("Error creating"),
                      duration: Duration(seconds: 1),
                    ),
                  );
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
                              child: Padding(
              padding: EdgeInsets.all(16.0),
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
                  const SizedBox(
                    height: 10,
                  ),
                  if (!showTextField)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            width: 234,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.cardPurpleColor,
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: SizedBox(
                                width:215.28 ,
                                height: 50,
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
                        ),
                        IconButton(
                            onPressed: () {
                              if (_textController.text.isNotEmpty) {
                                addNewTask();
                              }
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.white,
                              size: 35,
                            ))
                      ],
                    ),
                  Center(
                    child: SizedBox(
                      width: 234,
                      height: 470,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: tasksList.length,
                        itemBuilder: (context, index) {
                          final task = tasksList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 234,
                              height: 70,
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
                  ) ,
                  
              SizedBox(height: 4,),
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
            ));
      }),
    );
  }
}
