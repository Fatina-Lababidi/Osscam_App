import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/oneProject_bloc/one_project_bloc.dart';
import 'package:osscam/bloc/project_task_bloc/project_task_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/handle_exception/error_page.dart';
import 'package:osscam/pages/handle_exception/offline_page.dart';
import 'package:osscam/pages/tasks/project_details_page.dart';
import 'package:osscam/widgets/bugs_widget.dart';
import 'package:osscam/widgets/oneProjectLoading_widget.dart';
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
               ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
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
                    previousPage: OneProjectPage(
                      ProjectId: ProjectId,
                    ),
                  ),
                  type: PageTransitionType.fade,
                ),
              );
            } else if (state is OfflineOneProject) {
               ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
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
                  //!! what this ??
 Container(
      height: screenHeight * 0.07, //51,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textFieldColor),
        borderRadius: BorderRadius.circular(19),
        color: AppColors.textFieldColor,
      ),
      child: Row(
        children: [
          // Icon(
          //   ,
          //   color: AppColors.primaryColor,
          //   size: 30,
          // ),
          SizedBox(
            width: 5,
          ),
          Text(
            //?we will change this to widget.name depand on the prject we tap on
            state.projectsModel.name,
            // "project name",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.07, //screenHeight * 0.03, //25,
                color: Colors.white),
          ),
          const Spacer(),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.primaryColor,
            ),
          ),

        ],
      ).animate().fade(duration: .4.seconds, delay: .3.seconds),
    ),
                //  BugsNameWidget(
                //   name: state.projectsModel.name,),
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
                          height: screenHeight * 0.13, //105,
                          width: screenWidth * 1, //317,
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    // width: screenWidth * 0.35, //135,
                                    // height: screenHeight * 0.18, //105,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRect(
                                      clipBehavior: Clip.hardEdge,
                                      child: Image(
                                        filterQuality: FilterQuality.high,
                                        width: screenWidth * 0.35, //135,
                                        height: screenHeight * 0.18, //105,
                                        fit: BoxFit.fill,

                                        image: const AssetImage(
                                            AppImages.vector_image),
                                      ),
                                      // clipBehavior: Clip.antiAliasWithSaveLayer,
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
              return const OneProjectLoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
