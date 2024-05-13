import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/createNewProject_bloc/create_new_project_bloc.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/create_new_project_model.dart';
import 'package:osscam/pages/get_projects_page.dart';
import 'package:osscam/widgets/app_button.dart';
import 'package:osscam/widgets/app_textfield_login.dart';

class CreateNewProjectPage extends StatelessWidget {
  CreateNewProjectPage({super.key});

  TextEditingController _projectNameController = TextEditingController();
  TextEditingController _projectDescriptionController = TextEditingController();
  // TextEditingController _projectStatusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      SnackBar(content: Text('Success creating')));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetProjectsPage(),
                      ));
                } else if (State is ErrorCreateProject) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(label: "", onPressed: () {}),
                      content: const Text("Error creating"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                } else if (State is OfflineCreateProject) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(label: "", onPressed: () {}),
                      content: const Text("Offline while creating"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: Form(
                  key: formCreateKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('Create project'),
                      ),
                      LoginTextField(
                          text: 'name',
                          controller: _projectNameController,
                          hintText: 'please enter project name',
                          validate: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return 'please enter name';
                            }
                          }),
                      LoginTextField(
                          text: 'description',
                          controller: _projectDescriptionController,
                          hintText: 'please enter project Description',
                          validate: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return 'please enter Description';
                            }
                          }),
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
                      ButtonApp(
                        textColor: Colors.white,
                        color: AppColors.buttonColor,
                        text: 'Create project',
                        onTap: () {
                          if (formCreateKey.currentState!.validate()) {
                            context.read<CreateNewProjectBloc>().add(
                                  CreateNewProject(
                                    project: CreateNewProjectModel(
                                      projectName: _projectNameController.text,
                                      projectDescription:
                                          _projectDescriptionController.text,
                                      projectStatus:"NEW"
                                          ,
                                    ),
                                  ),
                                );
                          }
                        },
                      )
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
