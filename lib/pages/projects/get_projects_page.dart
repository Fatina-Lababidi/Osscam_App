import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/delete_project_bloc/delete_project_bloc.dart';
import 'package:osscam/bloc/project_task_bloc/project_task_bloc.dart';
import 'package:osscam/bloc/projects_bloc/projects_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/projects_model/get_projects_model.dart';
import 'package:osscam/pages/handle_exception/error_page.dart';
import 'package:osscam/pages/handle_exception/offline_page.dart';
import 'package:osscam/pages/tasks/project_details_page.dart';
import 'package:osscam/widgets/project_loading_widget.dart';
import 'package:osscam/widgets/search_textField.dart';
import 'package:page_transition/page_transition.dart';

class GetProjectsPage extends StatefulWidget {
  const GetProjectsPage({super.key});

  @override
  State<GetProjectsPage> createState() => _GetProjectsPageState();
}

// List<ProjectsModel>? projects = response.data ;
ValueNotifier<List<ProjectsModel>> result = ValueNotifier([]);

class _GetProjectsPageState extends State<GetProjectsPage> {
  // @override
  // void dispose() {
  //   result.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProjectsBloc()..add(GetProjects()),
        ),
        BlocProvider(
          create: (context) => ProjectTaskBloc(),
        ),
        BlocProvider<DeleteProjectBloc>(
          create: (context) => DeleteProjectBloc(),
        )
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: BlocConsumer<ProjectsBloc, ProjectsState>(
            listener: (context, state) {
              if (state is ErrorGetProjects) {
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
                    child: const ErrorPage(
                      previousPage: GetProjectsPage(),
                    ),
                    type: PageTransitionType.fade,
                  ),
                );
              } else if (state is OfflineOnGetProjects) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  // padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  // margin: EdgeInsets.all(10),
                  // behavior: SnackBarBehavior.floating,
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
                    child: const OfflinePage(
                      previousPage: GetProjectsPage(),
                    ),
                    type: PageTransitionType.fade,
                  ),
                );
              } else if (state is SuccessGetProjects) {
                ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    content: Text(
                      'Successful get projects...',
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: AppColors.cardGreenColor,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<ProjectsBloc, ProjectsState>(
                builder: (context, state) {
                  if (state is SuccessGetProjects) {
                    print(result);
                    return Column(
                      children: [
                        SearchTextField(
                          data: state.projects,
                        ),
                        ValueListenableBuilder(
                            valueListenable: result,
                            builder: (context, value, _) {
                              return Expanded(
                                child: (value.length != 0)
                                    ? Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: ListView.builder(
                                          itemCount: value.length,
                                          itemBuilder: (context, ind) {
                                            return GestureDetector(
                                              onTap: () {
                                                result.value = [];
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child: ProjectDetailsPage(
                                                      projectId: value[ind].id,
                                                      projectName:
                                                          value[ind].name,
                                                      projectDescription:
                                                          value[ind]
                                                              .description,
                                                    ),
                                                    type:
                                                        PageTransitionType.fade,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.continerColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                margin: const EdgeInsets.all(5),
                                                height:
                                                    screenHeight * 0.13, //105,
                                                width: screenWidth * 0.3, //317,
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          width: screenWidth *
                                                              0.35, //135,
                                                          height: screenHeight *
                                                              0.18, //105,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: ClipRect(
                                                            child: Image(
                                                              filterQuality:
                                                                  FilterQuality
                                                                      .high,
                                                              width: screenWidth *
                                                                  0.35, //135,
                                                              height:
                                                                  screenHeight *
                                                                      0.18, //105,
                                                              fit: BoxFit.fill,

                                                              image: const AssetImage(
                                                                  AppImages
                                                                      .vector_image),
                                                            ),
                                                            // clipBehavior: Clip.hardEdge,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Text(
                                                            value[ind]
                                                                .id
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Frijole',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Text(
                                                            'Project name : ' +
                                                                value[ind]
                                                                    .name
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .inputTextColor),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ).animate().scaleXY(
                                                  delay: Duration(
                                                      milliseconds:
                                                          50 + (ind * 10)),
                                                  duration: Duration(
                                                      milliseconds:
                                                          50 + (ind * 10))),
                                            );
                                          },
                                        ))
                                    : Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: ListView.builder(
                                          itemCount: state.projects.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                result.value = [];
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child:
                                                            ProjectDetailsPage(
                                                          projectId: state
                                                              .projects[index]
                                                              .id,
                                                          projectName: state
                                                              .projects[index]
                                                              .name,
                                                          projectDescription:
                                                              state
                                                                  .projects[
                                                                      index]
                                                                  .description,
                                                        ),
                                                        type: PageTransitionType
                                                            .fade));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.continerColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                margin: const EdgeInsets.all(5),
                                                height:
                                                    screenHeight * 0.13, //105,
                                                width: screenWidth * 0.3, //317,
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          width: screenWidth *
                                                              0.35, //135,
                                                          height: screenHeight *
                                                              0.18, //105,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: ClipRect(
                                                            clipBehavior: Clip
                                                                .values.first,
                                                            child: Image(
                                                              filterQuality:
                                                                  FilterQuality
                                                                      .high,
                                                              width: screenWidth *
                                                                  0.35, //135,
                                                              height:
                                                                  screenHeight *
                                                                      0.18, //105,
                                                              fit: BoxFit.fill,

                                                              image: const AssetImage(
                                                                  AppImages
                                                                      .vector_image),
                                                            ),
                                                            // clipBehavior: Clip.antiAliasWithSaveLayer,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Text(
                                                            state
                                                                .projects[index]
                                                                .id
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Frijole',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Text(
                                                            'Project name : ' +
                                                                state
                                                                    .projects[
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .inputTextColor),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ).animate().scaleXY(
                                                  delay: Duration(
                                                      milliseconds:
                                                          10 + (index * 10)),
                                                  duration: Duration(
                                                      milliseconds:
                                                          10 + (index * 10))),
                                            );
                                          },
                                        ),
                                      ),
                              );
                            })
                      ],
                    );
                  } else {
                    return const ProjectsLoadingWidget();
                  }
                },
              );
            },
          ),
        );
      }),
    );
  }
}
