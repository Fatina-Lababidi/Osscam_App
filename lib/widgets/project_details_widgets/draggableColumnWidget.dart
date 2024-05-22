import 'package:flutter/material.dart';
import 'package:osscam/model/get_tasks_model.dart';
import 'package:osscam/widgets/project_details_widgets/itemWidget.dart';

class DraggableColumn extends StatefulWidget {
  final List<Widget> widgetItems;
  final Color color;
  final String status;
  final Color textColor;
  final Function(BuildContext, GetAllTasks, Color, Color, String) onTap;
  const DraggableColumn({
    Key? key,
    required this.widgetItems,
    required this.color,
    required this.status,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  _DraggableColumnState createState() => _DraggableColumnState();
}

class _DraggableColumnState extends State<DraggableColumn> {
  List<Widget> items = [];
  bool isSnackBarShown = false;
  @override
  void initState() {
    super.initState();
    updateItems();
  }

  void updateItems() {
    items = List.from(widget.widgetItems);
    //?to create a new copy list from the widgetItem list , to avoid the directly modifiying to the origial list
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Widget>(
      //! // !!so here we take the status to update it ?
      onAcceptWithDetails: (details) {
        setState(() {
          widget.widgetItems.remove(details.data);
          items.add(details.data);
        });
        print('new status: ' + widget.status);
        // if (details.data is ItemWidget) {
        //   CreateNewTaskModel? taskModel = (details.data as ItemWidget).itemDescription;
        //   if (taskModel != null && taskModel.taskDescription == 'Description 5') {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(content: Text('Incorrect, please try again!')),
        //     );
        //   }
        // }
      },
// onLeave: (data) {
//   debugPrint('missed');
//   if (!isSnackBarShown && data != null && data is ItemWidget) {
//     CreateNewTaskModel? taskModel = (data as ItemWidget).itemDescription;
//     if (taskModel != null && taskModel.taskDescription == 'Description 5') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Incorrect, please try again!')),
//       );
//       isSnackBarShown = true;
//     }
//   }
// },
      // !!so here we take the status to update it ?
      //!!!! why it happeans more than one time ???
      onWillAccept: (data) {
        debugPrint('checking');
        if (data != null && data is ItemWidget) {
          GetAllTasks? taskModel = (data as ItemWidget).itemDescription;
          if (taskModel.taskDescription == 'Description 5') {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Incorrect, please try again!')),
            // );
            return false;
          }
        }
        return true;
      },

      builder: (context, candidateData, rejectedData) {
        return Column(
//! we have to test the items if its empty or not in order to add placeholder widge
          // but we can design it better not to appeare
          children: items.isEmpty
              ? [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 2, right: 2, bottom: 15),
                    child: Container(
                      width: 150,
                      height: 100,
                      child: Center(
                        child: Text('drop '),
                      ),
                      //elevation: 4
                    ),
                  ),
                ]
              : items
                  .map(
                    (item) => Draggable<Widget>(
                      data: item,
                      feedback: Padding(
                          padding: const EdgeInsets.only(
                              left: 2, right: 2, bottom: 15),
                          child: Material(
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              width: 150,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: widget.color,
                              ),
                              //  elevation: 8,

                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.status,
                                        style:
                                            TextStyle(color: widget.textColor),
                                      ),
                                      Icon(
                                        Icons.pest_control_outlined,
                                        color: widget.textColor,
                                      )
                                    ],
                                  ),
                                  item,
                                ],
                              ),
                            ),
                          )),
                      childWhenDragging: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, bottom: 15),
                        child: SizedBox(
                          width: 150,
                          height: 100,
                        ),
                      ),
                      // SizedBox(
                      //  width: 150,
                      //),
                      onDragCompleted: () {
                        //!! maybe here we have to make a conditoin depends on the response of the update request .......
                        //! maybe if its return true so update the ui using setState bellow ,if it false do nothing
                        //! or in the onAccepteWithDetails??
                        setState(() {
                          //? this line in order not to add a copy of the items but to transformate
                          items.remove(item);
                        });
                        print('privous status:' + widget.status);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, bottom: 15),
                        child: Container(
                          width: 150,
                          height: 100,
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
                                    style: TextStyle(color: widget.textColor),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.pest_control_outlined,
                                    color: widget.textColor,
                                  ),
                                ],
                              ),
                              item,
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
  }
}
