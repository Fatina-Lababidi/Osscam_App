// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/logout_bloc/logout_bloc.dart';
import 'package:osscam/bloc/project_task_bloc/project_task_bloc.dart';
import 'package:osscam/bloc/update_task_status_bloc/update_task_status_bloc.dart';
import 'package:osscam/model/get_tasks_model.dart';
import 'package:osscam/widgets/project_details_widgets/drawer.dart';
import 'package:osscam/widgets/project_details_widgets/expandedCardWidget.dart';
import 'package:osscam/widgets/project_details_widgets/myWidget.dart';
import 'package:osscam/widgets/project_details_widgets/projectDecriptionWidget.dart';
import 'package:osscam/widgets/project_details_widgets/projectNameWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:osscam/core/resources/color.dart';
// /! this page will take an object from the privous page in order to appear only the tasks of the taped continer?
//! //already the data of this page will apear after we tap on the continer it will take the id of the project in order to show its tasks

//!! we have a problem that when removing the holle items form column its space disapeare
// there is thing called placeholder widget ?? we have to know more about it ..!
//in order to ensure that the space for each column remains ...
class ProjectDetailsPage extends StatefulWidget {
  final int projectId;
  final String projectName;
  final String projectDescription;
  const ProjectDetailsPage(
      {super.key,
      required this.projectId,
      required this.projectName,
      required this.projectDescription});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  bool _isExpanded = false;

  void _changeContainerExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _showCardExpanded(BuildContext context, GetAllTasks task, Color color,
      Color textColor, String status) {
    Navigator.push(
        context,
        PageTransition(
          child: ExpandedCard(
            //!! i need to add the color and chape to this widget
            task: task,
            color: color,
            textAndIconColor: textColor,
            status: status,
          ),
          type: PageTransitionType.fade,
        )
        //? this appear a black material ><
        // MaterialPageRoute(
        //   builder: (context) => ExpandedCard(task: task),
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    //? this way divide the text into words ,but we also can use text.subString(0,100) to divide it by letters
    //? this will came from widget.description :
    String text = widget.projectDescription +
        ' Enterprise equipment management system Through which information is stored All types of equipment available And all maintenance operations are with Possibility of issuing reports and statements F Enterprise equipment management system Through which information is stored All types of equipment available And all maintenance operations are with Possibility of issuing reports and statements F Enterprise equipment management system Through which information is stored All types of equipment available And all maintenance operations are with Possibility of issuing reports and statements F';
    int wrodsCount = 30;
    final words = text.split(' ');
    final lessText = words.take(wrodsCount).join(' ');

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectTaskBloc>(
            create: (context) =>
                ProjectTaskBloc()..add(GetTasksByProject(widget.projectId))),
        BlocProvider<UpdateTaskStatusBloc>(
          create: (context) => UpdateTaskStatusBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        )
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            drawer: DrawerWidget(),
            backgroundColor: AppColors.primaryColor,
            body: BlocBuilder<ProjectTaskBloc, ProjectTaskState>(
              builder: (context, state) {
                if (state is ProjectTaskSuccess) {
                  List<GetAllTasks> tasks = state.tasks;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        projectNameWidget(
                          name: widget.projectName,
                        )
                            .animate()
                            .fade(duration: .3.seconds, delay: .2.seconds),
                        ProjectDescriptionWidget(
                          text: text,
                          lessText: lessText,
                          isExpanded: _isExpanded,
                          changeContainerExpanded: _changeContainerExpanded,
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: double.infinity,
                            height: 6000,
                            // Expanded(
                            //!! i have to fix this ...if i remove it there is no space to add new stuff
                            child: MyWidget(
                              project_id: widget.projectId,
                              tasks: tasks,
                              showCardFouced:
                                  //!! we can make it as function  before the build ?
                                  (BuildContext context,
                                      GetAllTasks task,
                                      Color color,
                                      Color textColor,
                                      String status) {
                                _showCardExpanded(
                                    context, task, color, textColor, status);
                              },
                            ),
                          )
                              .animate()
                              .fade(duration: .7.seconds, delay: .6.seconds),
                        ),
                      ],
                    ),
                  );
                } else if (state is ProjectTaskLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is Offline) {
                  return Center(
                    child: Text('offline'),
                  );
                } else {
                  return Center(
                    child: Text('Error'),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

// enum APP { NEW, COMPLETED }
// class A {
//   String name;
//   String App;
//   A({
//     required this.name,
//     required this.App,
//   });
// }

