import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/oneProject_bloc/one_project_bloc.dart';
import 'package:osscam/bloc/project_task_bloc/project_task_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/error_page.dart';
import 'package:osscam/pages/offline_page.dart';
import 'package:osscam/pages/project_details_page.dart';
import 'package:osscam/widgets/project_details_widgets/projectNameWidget.dart';
import 'package:page_transition/page_transition.dart';

class OneProjectPage extends StatelessWidget {
  final int ProjectId;
  const OneProjectPage({super.key, required this.ProjectId});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              OneProjectBloc()..add(GetOneProject(projectId: ProjectId)),
        ),
        BlocProvider(
          create: (context) => ProjectTaskBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: BlocConsumer<OneProjectBloc, OneProjectState>(
          listener: (context, state) {
            if (state is ErrorOneProject) {
              Navigator.push(
                context,
                PageTransition(
                  child: ErrorPage(
                    previousPage: OneProjectPage(
                      ProjectId: ProjectId,
                    ),
                  ),
                  type: PageTransitionType.fade,
                ),
              );
            } else if (state is OfflineOneProject) {
              Navigator.push(
                context,
                PageTransition(
                  child: OfflinePage(
                    previousPage: OneProjectPage(
                      ProjectId: ProjectId,
                    ),
                  ),
                  type: PageTransitionType.fade,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SuccessOneProject) {
              return Column(
                children: [
                  projectNameWidget(
                      name: state.projectsModel.name,
                      projectId: state.projectsModel.id),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: ProjectDetailsPage(
                                projectId: state.projectsModel.id,
                                projectName: state.projectsModel.name,
                                projectDescription:
                                    state.projectsModel.description,
                              ),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.continerColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(5),
                          height:screenHeight*0.13, //105,
                          width: screenWidth*1,//317,
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: screenWidth * 0.25, //135,
                                    height: screenHeight * 0.12, //105,
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: const AssetImage(
                                          AppImages.vector_image),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      state.projectsModel.id.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Frijole',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Project name : ' +
                                          state.projectsModel.name,
                                      style: TextStyle(
                                          color: AppColors.inputTextColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator(color: AppColors.textFieldColor,));
            }
          },
        ),
      ),
    );
  }
}
