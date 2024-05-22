import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/project_task_bloc/project_task_bloc.dart';
import 'package:osscam/bloc/projects_bloc/projects_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/get_projects_model.dart';
import 'package:osscam/pages/error_page.dart';
import 'package:osscam/pages/offline_page.dart';
import 'package:osscam/pages/project_details_page.dart';
import 'package:osscam/widgets/project_loading_widget.dart';
import 'package:osscam/widgets/search_textField.dart';
import 'package:page_transition/page_transition.dart';

//! we have to fix the text ..
class GetProjectsPage extends StatefulWidget {
  const GetProjectsPage({super.key});

  @override
  State<GetProjectsPage> createState() => _GetProjectsPageState();
}

// List<ProjectsModel>? projects = response.data ;
ValueNotifier<List<ProjectsModel>> result = ValueNotifier([]);

class _GetProjectsPageState extends State<GetProjectsPage> {
  @override

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     setState(() {
  //       startAnimation = true;
  //     });
  //   });
  // }

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
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: BlocConsumer<ProjectsBloc, ProjectsState>(
            listener: (context, state) {
              if (state is ErrorGetProjects) {
                Navigator.push(
                    context,
                    PageTransition(
                        child:const ErrorPage(
                          previousPage: GetProjectsPage(),
                        ),
                        type: PageTransitionType.fade));
              } else if (state is OfflineOnGetProjects) {
                Navigator.push(
                    context,
                    PageTransition(
                        child:const OfflinePage(
                          previousPage: GetProjectsPage(),
                        ),
                        type: PageTransitionType.fade));
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
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child:
                                                            ProjectDetailsPage(
                                                          projectId: state
                                                              .projects[ind].id,
                                                          projectName: state
                                                              .projects[ind]
                                                              .name,
                                                          projectDescription:
                                                              state
                                                                  .projects[ind]
                                                                  .description,
                                                        ),
                                                        type: PageTransitionType
                                                            .fade));
                                              },
                                              child: Container(
                                                // curve: Curves.easeInOut,
                                                //  duration:
                                                //  Duration(milliseconds: 300 + (index * 100)),
                                                // transform: Matrix4.translationValues(
                                                //    0, 0, 0),
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
                                                          width:
                                                              135, //screenWidth*0.25, //135,
                                                          height:
                                                              105, // screenHeight*0.13,//105,
                                                          child: Image(
                                                            fit: BoxFit.cover,
                                                            image: const AssetImage(
                                                                AppImages
                                                                    .vector_image),
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
                                                // curve: Curves.easeInOut,
                                                //  duration:
                                                //  Duration(milliseconds: 300 + (index * 100)),
                                                // transform: Matrix4.translationValues(
                                                //    0, 0, 0),
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
                                                          width:
                                                              135, //screenWidth*0.25, //135,
                                                          height:
                                                              105, // screenHeight*0.13,//105,
                                                          child: Image(
                                                            fit: BoxFit.cover,
                                                            image: const AssetImage(
                                                                AppImages
                                                                    .vector_image),
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
                                                          200 + (index * 10)),
                                                  duration: Duration(
                                                      milliseconds:
                                                          100 + (index * 10))),
                                            );
                                          },
                                        ),
                                      ),
                              );
                            })
                      ],
                    );
                    // } else if (state is OfflineOnGetProjects) {
                    //   return const Center(
                    //     child: Text('offline'),
                    //   );
                    // } else if (state is ErrorGetProjects) {
                    //   return const Center(
                    //     child: Text(
                    //       'Error',
                    //     ),
                    //   );
                  } else {
                    return ProjectsLoadingWidget();
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
