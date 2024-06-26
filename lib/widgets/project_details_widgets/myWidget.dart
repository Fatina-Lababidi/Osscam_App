import 'package:flutter/material.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/tasks_model/get_tasks_model.dart';
import 'package:osscam/widgets/project_details_widgets/draggableColumnWidget.dart';

class MyWidget extends StatefulWidget {
  final List<GetAllTasks> tasks;
  final Function(BuildContext, GetAllTasks, Color, Color, String)
      showCardFouced;
  final int projectId;
  final String projectName;
  final String projectDescription;

  const MyWidget({
    Key? key,
    required this.showCardFouced,
    required this.tasks,
    required this.projectId,
    required this.projectName,
    required this.projectDescription,
  }) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
//? this data will came from back that just for testing ...
  List<GetAllTasks> allTasks = [];
  //   CreateNewTaskModel(
  //       taskName: 'Task 1',
  //       taskDescription: 'Description 1',
  //       taskStatus: 'NEW',
  //       project_id: 1),
  //   CreateNewTaskModel(
  //       taskName: 'Task 2',
  //       taskDescription: 'Description 2',
  //       taskStatus: 'ON_PROGRESS',
  //       project_id: 1),
  //   CreateNewTaskModel(
  //       taskName: 'Task 3',
  //       taskDescription: 'Description 3',
  //       taskStatus: 'DONE',
  //       project_id: 1),
  //   CreateNewTaskModel(
  //       taskName: 'Task 4',
  //       taskDescription: 'Description 4',
  //       taskStatus: 'NEW',
  //       project_id: 1),
  //   CreateNewTaskModel(
  //       taskName: 'Task 5',
  //       taskDescription: 'Description 5',
  //       taskStatus: 'ON_PROGRESS',
  //       project_id: 1),
  //   CreateNewTaskModel(
  //       taskName: 'Task 6',
  //       taskDescription: 'Description 6',
  //       taskStatus: 'DONE',
  //       project_id: 1),
  //   CreateNewTaskModel(
  //       taskName: 'Task 7',
  //       taskDescription: 'Description 7',
  //       taskStatus: 'ON_PROGRESS',
  //       project_id: 1),
  // ];
  @override
  void initState() {
    super.initState();
    allTasks = widget.tasks;
    // if (isUpdate == true) {
    //   setState(() {
    //     allTasks = widget.tasks;
    //   });
    // isUpdate = false;
    // }
  }

//! here i have to but a fucntion to update the date ..
  // void afterUpdateStatus() {
  //   setState(() {
  //     allTasks = widget.tasks;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //?? we have to filtering the tasks by status ..

    List<GetAllTasks> newTasks = allTasks
        .where((onlyNewtask) => onlyNewtask.taskStatus == "NEW")
        .toList();
//! if we need to pass the color throw the model
    // List<CreateNewTaskModelWithColor> newColoredTask = List.generate(
    //     newTasks.length,
    //     (index) => CreateNewTaskModelWithColor(
    // taskName: newTasks[index].taskName,
    //         taskDescription: newTasks[index].taskDescription,
    //         taskStatus: newTasks[index].taskStatus,
    //         project_id: newTasks[index].project_id,
    //         color: AppColors.checkboxColor));

    List<GetAllTasks> onProgressTasks =
        allTasks.where((task) => task.taskStatus == "IN_PROGRESS").toList();
    List<GetAllTasks> doneTasks =
        allTasks.where((task) => task.taskStatus == "COMPLETED").toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DraggableColumn(
          projectDescription: widget.projectDescription,
          projectName: widget.projectName,
          projectId: widget.projectId,
          key: UniqueKey(),
          tasks: newTasks,
          // .map((task) => ItemWidget(
          //     task,
          //     widget.showCardFouced,
          //     AppColors.cardPurpleColor,
          //     AppColors.backingTextColor,
          //     "Backing"))
          // .toList(),
          status: "Backing",
          textColor: AppColors.backingTextColor,
          color: AppColors.cardPurpleColor,
          onTap: widget.showCardFouced,
        ),
        DraggableColumn(
          projectDescription: widget.projectDescription,
          projectName: widget.projectName,
          projectId: widget.projectId,
          key: UniqueKey(),
          // items: [
          //   ItemWidget('Item 4'),
          //   ItemWidget('Item 5'),
          //   ItemWidget('Item 6'),
          // ],
          tasks: onProgressTasks,
          // .map((e) => ItemWidget(
          //     e,
          //     widget.showCardFouced,
          //     AppColors.cardApricotColor,
          //     AppColors.progressTextColor,
          //     "on progress"))
          // .toList(),
          status: "on progress",
          textColor: AppColors.progressTextColor,
          color: AppColors.cardApricotColor,
          onTap: widget.showCardFouced,
        ),
        DraggableColumn(
          projectDescription: widget.projectDescription,
          projectName: widget.projectName,
          projectId: widget.projectId,
          key: UniqueKey(),
          //   items: [ItemWidget('item 7'), ItemWidget('item 8')],
          tasks: doneTasks,
          // .map((e) => ItemWidget(e, widget.showCardFouced,
          //     AppColors.cardGreenColor, AppColors.doneTextColor, "Done"))
          // .toList(),
          status: "Done",
          textColor: AppColors.doneTextColor,
          color: AppColors.cardGreenColor,
          onTap: widget.showCardFouced,
        ),
      ],
    );
  }
}
