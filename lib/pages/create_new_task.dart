import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/createNewTask/create_new_task_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/create_new_task.dart';
import 'package:osscam/pages/get_projects_page.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class CreateNewTaskPage extends StatelessWidget {
  CreateNewTaskPage({super.key});

  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
 // TextEditingController _project_idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final formCreateKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => CreateNewTaskBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SingleChildScrollView(
            child: BlocListener<CreateNewTaskBloc, CreateNewTaskState>(
              listener: (context, state) {
                if (state is SuccessCreateTask) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Success creating')));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => GetProjectsPage(),
                  //   ),
                  // );
                  Navigator.push(
                      context,
                      PageTransition(
                          child:const GetProjectsPage(),
                          type: PageTransitionType.fade));
                } else if (State is ErrorCreateTask) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(label: "", onPressed: () {}),
                      content: const Text("Error creating"),
                      duration:const Duration(seconds: 1),
                    ),
                  );
                } else if (State is OfflineCreateTask) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(label: "", onPressed: () {}),
                      content: const Text("Offline while creating"),
                      duration:const Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: Form(
                  key: formCreateKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          padding: EdgeInsets.only(left: screenWidth * 0.09),
                          child: Text(
                            'task name',
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
                        Center(
                          child: Container(
                            width: screenWidth * 0.9, // 310,
                            height: screenHeight * 0.09, //75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              cursorColor: AppColors.primaryColor,
                              maxLines: 4,
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "please enter task's name";
                                }
                              },
                              controller: _taskNameController,
                              obscureText: false,
                              style:const TextStyle(color: AppColors.inputTextColor),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fade(delay: .7.seconds, duration: .6.seconds),
                        //          Padding(
                        //   padding: EdgeInsets.only(left: screenWidth * 0.09),
                        //   child: Text(
                        //     'project_id',
                        //     style: TextStyle(
                        //       fontSize: screenWidth * 0.05,
                        //       fontWeight: FontWeight.w600,
                        //       color: AppColors.textCreateColor,
                        //     ),
                        //   ),
                        // )
                        //     .animate()
                        //     .fade(delay: .5.seconds, duration: .4.seconds),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Center(
                        //   child: Container(
                        //     width: screenWidth * 0.9, // 310,
                        //     height: screenHeight * 0.09, //75,
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(15),
                        //     ),
                        //     child: TextFormField(
                        //       cursorColor: AppColors.primaryColor,
                        //       maxLines: 4,
                        //       validator: (value) {
                        //         if (value!.isNotEmpty) {
                        //           return null;
                        //         } else {
                        //           return "please enter project_id";
                        //         }
                        //       },
                        //       controller: _project_idController,
                        //       obscureText: false,
                        //       style: TextStyle(color: AppColors.inputTextColor),
                        //       decoration: const InputDecoration(
                        //         contentPadding: EdgeInsets.symmetric(
                        //             horizontal: 16, vertical: 16),
                        //         border: InputBorder.none,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.09),
                          child: Text(
                            'task discription',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textCreateColor,
                            ),
                          ),
                        )
                            .animate()
                            .fade(delay: .9.seconds, duration: .8.seconds),
                        const SizedBox(
                          height: 20,
                        ),

                        Center(
                          child: Container(
                            width: screenWidth * 0.9, // 310,
                            height: screenHeight * 0.45, // 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              obscureText: false,
                              style:const TextStyle(color: AppColors.inputTextColor),
                              cursorColor: AppColors.primaryColor,
                              maxLines: 12,
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "please enter task's script";
                                }
                              },
                              controller: _taskDescriptionController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fade(delay: 1.1.seconds, duration: 1.seconds),

                        //change to options : NEW, IN_PROGRESS, COMPLETED
                        // LoginTextField(
                        //     text: 'status',
                        //     controller: _projectStatusController,
                        //     hintText: 'please enter project status',
                        //     validate: (value) {
                        //       if (value!.isNotEmpty) {
                        //         return null;
                        //       } else {
                        //         return 'please enter status';
                        //       }
                        //     }),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<CreateNewTaskBloc, CreateNewTaskState>(
                          builder: (context, state) {
                            if (state is CreateNewTaskInitial) {
                              return ButtonApp(
                                textColor: AppColors.primaryColor,
                                color: AppColors.buttonColor,
                                text: 'Create',
                                onTap: () {
                                  if (formCreateKey.currentState!.validate()) {
                                    context.read<CreateNewTaskBloc>().add(
                                            CreateNewTask(
                                                createNewTaskModel:
                                                    CreateNewTaskModel(
                                          taskName: _taskNameController.text,
                                          taskDescription:
                                              _taskDescriptionController.text,
                                          taskStatus: "NEW",
                                          project_id:5 ,
                                          // CreateNewTaskModel.fromJson("https://projects-management-system.onrender.com/api/v1/tasks").project_id ,//!we have to take it form back?
                                        ),
                                        //  id:ProjectsModel.fromJson("id").id
                                         ));
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
                            .animate()
                            .fade(delay: 1.3.seconds, duration: 1.2.seconds)
                      ],
                    ),
                  )),
            ),
          ),
        );
      }),
    );
  }
}
