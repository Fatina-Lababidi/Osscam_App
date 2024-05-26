import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/add_task/add_task_bloc.dart';
import 'package:osscam/bloc/createNewTask/create_new_task_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/create_new_task.dart';
import 'package:osscam/model/get_projects_model.dart';
import 'package:osscam/pages/create_new_project_page.dart';
import 'package:osscam/pages/error_page.dart';
import 'package:osscam/pages/get_projects_page.dart';
import 'package:osscam/pages/offline_page.dart';
import 'package:osscam/service/base_service.dart';
import 'package:osscam/service/get_project.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:osscam/widgets/create_task_textField.dart';
import 'package:page_transition/page_transition.dart';

class TextFieldListPage extends StatefulWidget {
  TextFieldListPage({super.key, required this.id});
  final int id;
  @override
  _TextFieldListPageState createState() => _TextFieldListPageState();
}

class _TextFieldListPageState extends State<TextFieldListPage> {
  List<String> textList = [''];
  TextEditingController taskDescController = TextEditingController();

  @override
  void dispose() {
    taskDescController.dispose();
    super.dispose();
  }

  // ValueNotifier<ListOf<ProjectsModel>> project =
  //     ValueNotifier(ListOf(project: []));
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final formCreateKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => AddTaskBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: SingleChildScrollView(
                child: BlocListener<AddTaskBloc, AddTaskState>(
                    listener: (context, state) {
                      if (state is NewTextFieldCreated) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Success creating')));
                    
                        Navigator.push(
                            context,
                            PageTransition(
                                child: GetProjectsPage(
                                    // id: state.project.id,
                                    ),
                                // GetProjectsPage(),
                                type: PageTransitionType.fade));
                      } else if (State is OfflineCreateTask) {
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
                                    previousPage: TextFieldListPage(
                                  id: 2,
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
                                    previousPage: TextFieldListPage(
                                  id: 2,
                                )),
                                type: PageTransitionType.fade));
                      }
                    },
                    child: Form(
                      key: formCreateKey,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            )
                                .animate()
                                .fade(delay: .3.seconds, duration: .2.seconds),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: screenWidth * 0.09),
                              child: Text(
                                'Tasks',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textCreateColor,
                                ),
                              ),
                            )
                                .animate()
                                .fade(delay: .5.seconds, duration: .4.seconds),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                                trailing: IconButton(
                                        onPressed: () {
                                           setState(() {
                                            textList.add('');
                                            taskDescController.clear();
                                            print(
                                                'Added empty string to the list: $textList');
                                          });
                                            if (taskDescController.text == '' ||
                                                taskDescController.text == null) {
                                              context
                                                  .read<AddTaskBloc>()
                                                  .add(CreateNewTextFiel());
                                              taskDescController.clear();
                                            } else {
                                          // textList = taskDescController.text;

                                            context.read<AddTaskBloc>().add(
                                                  SubmitOneTask(
                                                    oneTask: CreateNewTaskModel(
                                                        taskDescription:
                                                            taskDescController
                                                                .text,
                                                        taskStatus: 'NEW',
                                                        project_id: 2),
                                                  ),
                                                );
                                            context
                                                .read<AddTaskBloc>()
                                                .add(CreateNewTextFiel());
                                          }
                                          // ResutlModel result = await getProjects();
                                          // if (result is ListOf<ProjectsModel>) {
                                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          //     content: Text("Success To Fetch data"),
                                          //     backgroundColor: Colors.green,
                                          //   ));

                                          //   project.value = result;
                                          // } else {
                                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          //     content: Text(" not Success To Fetch data"),
                                          //     backgroundColor: Colors.red,
                                          //   ));
                                          // }
                                         
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                          size: 35,
                                        ))
                                    .animate()
                                    .fade(
                                        delay: 1.3.seconds,
                                        duration: 1.2.seconds),
                                title:
                                    // BlocBuilder<AddTaskBloc, AddTaskState>(
                                    //   builder: (context, state) {
                                    //     if (state is NewTextFieldCreated) {
                                    //      return
                                    Center(
                                  child: Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: textList.length,
                                        itemBuilder: (context, index) {
                                          if (index == textList.length - 1) {
                                            // context
                                            //     .read<AddTaskBloc>()
                                            //     .add(CreateNewTextFiel());
                                            // taskDescController.clear();
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Container(
                                                            width: 234,
                                                            //  screenWidth *
                                                            //     0.468, //234,
                                                            height: 70,
                                                            // screenHeight *
                                                            //     0.14, // 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: AppColors
                                                                  .cardPurpleColor,
                                                            ),
                                                            //  elevation: 8,

                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          215.28,
                                                                      height:
                                                                          50,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      child:
                                                                          TextFormField(
                                                                        cursorColor:
                                                                            AppColors.primaryColor,
                                                                        maxLines:
                                                                            1,
                                                                        validator:
                                                                            (value) {
                                                                          if (value!
                                                                              .isNotEmpty) {
                                                                            return null;
                                                                          } else {
                                                                            return "please enter the task";
                                                                          }
                                                                        },
                                                                        controller:
                                                                            taskDescController,
                                                                        onChanged:
                                                                            (value) {
                                                                          textList[index] =
                                                                              value;
                                                                        },
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              'Enter Text',
                                                                          border: OutlineInputBorder(
                                                                              borderSide: BorderSide.none,
                                                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )),
                                                    // SizedBox(width: 50),
                                                  ],
                                                ),
                                              ],
                                            );
                                          } else {
                                            taskDescController =
                                                TextEditingController();
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    width: 234,
                                                    //  screenWidth *
                                                    //     0.468, //234,
                                                    height: 70,
                                                    // screenHeight *
                                                    //     0.14, // 70,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: AppColors
                                                          .cardPurpleColor,
                                                    ),
                                                    //  elevation: 8,

                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                                width: 215.28,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Card(
                                                                  child:
                                                                      ListTile(
                                                                    title: Text(
                                                                        textList[
                                                                            index]),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                            //  Card(
                                            //   child:
                                            //    ListTile(
                                            //     title: Text(textList[index]),
                                            //   ),
                                            // );
                                          }
                                        }),
                                  ).animate().fade(
                                      delay: 1.5.seconds,
                                      duration: 1.2.seconds),
                                )
                                //     }else{
                                //       return Container();
                                //     }
                                //   },
                                // ),
                                ),
                            // Row(
                            //   children: [

                            //   ],
                            // ),
                            SizedBox(
                              height: 200,
                            ),
                            BlocBuilder<AddTaskBloc, AddTaskState>(
                              builder: (context, state) {
                                if (state is AddTaskInitial) {
                                  return ButtonApp(
                                    textColor: AppColors.primaryColor,
                                    color: AppColors.buttonColor,
                                    text: 'Create',
                                    onTap: () {
                                      if (formCreateKey.currentState!
                                          .validate()) {
                                        List<String> filteredList = textList
                                            .where(
                                                (element) => element.isNotEmpty)
                                            .toList();
                                        print('Filtered list: $filteredList');
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
                            ).animate().fade(
                                delay: 1.6.seconds, duration: 1.2.seconds),
                          ],
                        ),
                      ),
                    ))));
      }),
    );
  }
}
