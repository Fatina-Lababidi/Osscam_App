import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/createNewProject_bloc/create_new_project_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/projects_model/create_new_project_model.dart';
import 'package:osscam/pages/tasks_pages/create_new_task_page.dart';
import 'package:osscam/pages/handle_exception_pages/error_page.dart';
import 'package:osscam/pages/handle_exception_pages/offline_page.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:page_transition/page_transition.dart';

class CreateNewProjectPage extends StatelessWidget {
  CreateNewProjectPage({super.key});

  TextEditingController _projectNameController = TextEditingController();
  TextEditingController _projectDescriptionController = TextEditingController();
  // TextEditingController _projectStatusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final formCreateKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => CreateNewProjectBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SingleChildScrollView(
            child: BlocListener<CreateNewProjectBloc, CreateNewProjectState>(
              listener: (context, state) {
                if (state is SuccessCreateProject) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      content: Text(
                        'Successful creating new project ...',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: AppColors.cardGreenColor,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.push(
                      context,
                      PageTransition(
                          child: CreateNewTaskPage(
                            id: state.project.id,
                          ),
                          // GetProjectsPage(),
                          type: PageTransitionType.fade));
                } else if (State is OfflineCreateProject) {
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
                          child:
                              OfflinePage(previousPage: CreateNewProjectPage()),
                          type: PageTransitionType.fade));
                } else if (state is ErrorCreateProject) {
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
                          child:
                              ErrorPage(previousPage: CreateNewProjectPage()),
                          type: PageTransitionType.fade));
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
                            'Project name',
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
                                  return "please enter project's name";
                                }
                              },
                              controller: _projectNameController,
                              obscureText: false,
                              style: TextStyle(color: AppColors.inputTextColor),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                border: InputBorder.none,
                                hintText: 'Enter the project name ...',
                                hintStyle: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fade(delay: .7.seconds, duration: .6.seconds),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.09),
                          child: Text(
                            'Project script',
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
                              style: TextStyle(color: AppColors.inputTextColor),
                              cursorColor: AppColors.primaryColor,
                              maxLines: 12,
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "please enter project's script";
                                }
                              },
                              controller: _projectDescriptionController,
                              decoration: const InputDecoration(
                                hintText: "Enter the project script ...",
                                hintStyle: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12),
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
                        BlocBuilder<CreateNewProjectBloc,
                                CreateNewProjectState>(
                          builder: (context, state) {
                            if (state is CreateNewProjectInitial) {
                              return ButtonApp(
                                textColor: AppColors.primaryColor,
                                color: AppColors.buttonColor,
                                text: 'Create',
                                onTap: () {
                                  if (formCreateKey.currentState!.validate()) {
                                    context.read<CreateNewProjectBloc>().add(
                                          CreateNewProject(
                                            project: CreateNewProjectModel(
                                              projectName:
                                                  _projectNameController.text,
                                              projectDescription:
                                                  _projectDescriptionController
                                                      .text,
                                              projectStatus: "NEW",
                                            ),
                                          ),
                                        );
                                  }
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
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
