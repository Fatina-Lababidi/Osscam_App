import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/project_task_bloc/project_task_bloc.dart';
import 'package:osscam/bloc/update_task_status_bloc/update_task_status_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/tasks_model/get_tasks_model.dart';
import 'package:osscam/pages/handle_exception_pages/offline_page.dart';
import 'package:osscam/pages/tasks_pages/project_details_page.dart';
import 'package:osscam/widgets/project_details_widgets/itemWidget.dart';
import 'package:page_transition/page_transition.dart';

class DraggableColumn extends StatefulWidget {
  final List<GetAllTasks> tasks;
  final Color color;
  final String status;
  final Color textColor;
  final Function(BuildContext, GetAllTasks, Color, Color, String) onTap;
  final int projectId;
  final String projectName;
  final String projectDescription;
  const DraggableColumn({
    super.key,
    required this.tasks,
    required this.color,
    required this.status,
    required this.textColor,
    required this.onTap,
    required this.projectId,
    required this.projectName,
    required this.projectDescription,
  });

  @override
  _DraggableColumnState createState() => _DraggableColumnState();
}

class _DraggableColumnState extends State<DraggableColumn> {
  List<GetAllTasks> items = [];
  bool isSnackBarShown = false;
  UniqueKey snackBarKey = UniqueKey();
  @override
  void initState() {
    super.initState();
    updateItems();
  }

  void updateItems() {
    items = List.from(widget.tasks);
    //?to create a new copy list from the widgetItem list , to avoid the directly modifiying to the origial list
  }

  void taskUpdateStatus(GetAllTasks taskModel) {
    String status;
    if (widget.status == "Done") {
      status = "COMPLETED";
    } else if (widget.status == "Backing") {
      status = "NEW";
    } else {
      status = "IN_PROGRESS";
    }
    context.read<UpdateTaskStatusBloc>().add(
          UpdateEvent(
            task_id: taskModel.taskId,
            project_id: widget.projectId,
            taskStatus: status,
            taskDescription: taskModel.taskDescription,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHieght = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return BlocConsumer<UpdateTaskStatusBloc, UpdateTaskStatusState>(
      listener: (context, state) {
        if (state is FailedUpdate) {
          items = List.from(widget.tasks);
          errorDialog(context, screenWidth);
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        } else if (state is SuccessUpdate ) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(
          //       SnackBar(
          //         key: snackBarKey,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(10),
          //                 topRight: Radius.circular(10))),
          //         content: Text(
          //           'Successful update status ...',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //         backgroundColor: AppColors.cardGreenColor,
          //         duration: Duration(seconds: 2),
          //         // onVisible: () {
          //         //   isSnackBarShown = false;
          //         // },
          //       ),
          //     )
          //     .closed
          //     .then((_) {
          //   isSnackBarShown = false;
          // });

          context
              .read<ProjectTaskBloc>()
              .add(GetTasksByProject(widget.projectId));
        } else if (state is OfflineUpdate) {
          Navigator.push(
              context,
              PageTransition(
                  child: OfflinePage(
                      previousPage: ProjectDetailsPage(
                          projectId: widget.projectId,
                          projectName: widget.projectName,
                          projectDescription: widget.projectDescription)),
                  type: PageTransitionType.fade));
        }
      },
      builder: (context, state) {
        return DragTarget<GetAllTasks>(
          //! // !!so here we take the status to update it ?
          onAcceptWithDetails: (details) {
            //! for update
            taskUpdateStatus(details.data);
            widget.tasks.remove(details.data);
            items.add(details.data);
            print('new status: ' + widget.status);
          },
          builder: (context, candidateData, rejectedData) {
            return Column(
              //! we have to test the items if its empty or not in order to add placeholder widge
              // but we can design it better not to appeare
              children: items.isEmpty
                  ? [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, bottom: 15),
                        child: SizedBox(
                          width: screenWidth * 0.3, //150,
                          height: screenHieght * 0.125, // 100,
                        ),
                      ),
                    ]
                  : items
                      .map(
                        (task) => Draggable<GetAllTasks>(
                          data: task, // item,
                          feedback: Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, bottom: 15),
                              child: Material(
                                borderRadius: BorderRadius.circular(7),
                                child: Container(
                                  width: screenWidth * 0.3, //150,
                                  height: screenHieght * 0.125, // 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: widget.color,
                                  ),
                                  //  elevation: 8,

                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.status,
                                            style: TextStyle(
                                                color: widget.textColor),
                                          ),
                                          Icon(
                                            task.hasBugs
                                                ? Icons.pest_control
                                                : Icons.pest_control_outlined,
                                            color: widget.textColor,
                                          )
                                        ],
                                      ),
                                      ItemWidget(
                                        task,
                                        widget.onTap,
                                        widget.color,
                                        widget.textColor,
                                        widget.status,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          childWhenDragging: Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, bottom: 15),
                            child: SizedBox(
                              width: screenWidth * 0.3, //150,,
                              height: screenHieght * 0.125, // 100,
                            ),
                          ),
                          // SizedBox(
                          //  width: 150,
                          //),
                          onDragCompleted: () {
                            //!! maybe here we have to make a conditoin depends on the response of the update request .......
                            //! maybe if its return true so update the ui using setState bellow ,if it false do nothing
                            //! or in the onAccepteWithDetails??

                            //? this line in order not to add a copy of the items but to transformate
                            // items.remove(item);
                            items.remove(task);
                            print('privous status:' + widget.status);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, bottom: 15),
                            child: Container(
                              width: screenWidth * 0.3, //150,
                              height: screenHieght * 0.125, // 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: widget.color,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.status,
                                        style: TextStyle(
                                            color: widget.textColor,
                                            fontSize: screenWidth * 0.035),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        task.hasBugs
                                            ? Icons.pest_control
                                            : Icons.pest_control_outlined,
                                        color: widget.textColor,
                                      ),
                                    ],
                                  ),
                                  ItemWidget(
                                    task,
                                    widget.onTap,
                                    widget.color,
                                    widget.textColor,
                                    widget.status,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            );
          },
        );
      },
    );
  }

  Future<dynamic> errorDialog(BuildContext context, double screenWidth) {
    return showDialog(
      barrierDismissible: false,
      barrierColor: AppColors.primaryColor.withOpacity(0.3),
      context: context,
      builder: (context) {
        return Center(
          child: Dialog(
            backgroundColor: AppColors.textFieldColor.withOpacity(0.4),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImages.noInternetImage)
                      .animate()
                      .fadeIn(duration: 0.2.seconds, delay: .1.seconds),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to update',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ).animate().fadeIn(duration: .4.seconds, delay: .3.seconds),
                  const SizedBox(height: 8),
                  const Text(
                    'Please try again later.',
                    style:
                        TextStyle(fontSize: 16, color: AppColors.primaryColor),
                  ).animate().fadeIn(duration: .6.seconds, delay: .5.seconds),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
