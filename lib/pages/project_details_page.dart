import 'package:blur/blur.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/create_new_task.dart';
import 'package:page_transition/page_transition.dart';

//!! we have a problem that when removing the holle items form column its space disapeare
// there is thing called placeholder widget ?? we have to know more about it ..!
//in order to ensure that the space for each column remains ...
class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    //? this way divide the text into words ,but we also can use text.subString(0,100) to divide it by letters
    //? this will came from widget.description :
    String text =
        ' Enterprise equipment management system Through which information is stored All types of equipment available And all maintenance operations are with Possibility of issuing reports and statements F Enterprise equipment management system Through which information is stored All types of equipment available And all maintenance operations are with Possibility of issuing reports and statements F Enterprise equipment management system Through which information is stored All types of equipment available And all maintenance operations are with Possibility of issuing reports and statements F';
    int wrodsCount = 30;
    final words = text.split(' ');
    final lessText = words.take(wrodsCount).join(' ');
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 51,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textFieldColor),
                borderRadius: BorderRadius.circular(19),
                color: AppColors.textFieldColor,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                    onPressed: () {
//? here the drawer
                    },
                  ),
                  const Spacer(),
                  const Text(
//?we will change this to widget.name depand on the prject we tap on
                    "project name",
                    style: TextStyle(fontSize: 25, color: Colors.white),
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
                    width: 2,
                  ),
                  PopupMenuButton<int>(
                    onSelected: (value) {
                      switch (value) {
                        case 1:
                          //what will delet exactually??
                          break;
                        case 2:
                          // edit : will nav to the create or what ?
                          break;
                        case 3:
                          //copy Id ;
                          break;
                      }
                    },
                    clipBehavior: Clip.antiAlias,
                    surfaceTintColor: AppColors.buttonColor,
                    popUpAnimationStyle: AnimationStyle(
                        curve: Curves.easeInOut, duration: .2.seconds),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: AppColors.dropTextColor,
                                ),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.dropTextColor),
                                )
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.mode_edit_outline_rounded,
                                  color: AppColors.dropTextColor,
                                ),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.dropTextColor),
                                )
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: [
                            Icon(
                              Icons.copy,
                              color: AppColors.dropTextColor,
                            ),
                            Text(
                              "Copy ID",
                              style: TextStyle(
                                  fontSize: 10, color: AppColors.dropTextColor),
                            )
                          ],
                        ),
                      ),
                    ],
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ).animate().fade(duration: .4.seconds, delay: .3.seconds),
            ).animate().fade(duration: .3.seconds, delay: .2.seconds),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  // duration: const Duration(
                  //   milliseconds: 500,
                  // ),
                  // curve: Curves.easeInOut,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //! second way : this better
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: RichText(
                      text: TextSpan(
                          text: _isExpanded ? text : lessText,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                          children: [
                            TextSpan(
                              text: _isExpanded ? "read less" : " ...read more",
                              style: const TextStyle(
                                color: AppColors.textFieldColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.textFieldColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _changeContainerExpanded,
                            ),
                          ]),
                    ).animate().fade(duration: .7.seconds, delay: .6.seconds),
                  )

                  //!! first try : the problem of this that the text(read more) under the text but we need it next to
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(_isExpanded ? text : lessText),
                  //     //  const SizedBox(
                  //     //     height: 10,
                  //     //   ),
                  //     Align(
                  //       alignment: Alignment.bottomRight,
                  //       child: GestureDetector(
                  //         onTap: _changeContainerExpanded,
                  //         child: Text(
                  //           _isExpanded ? "read less" : '...read more',
                  //           style: const TextStyle(
                  //               color: AppColors.textFieldColor,
                  //               decoration: TextDecoration.underline,
                  //               decorationColor: AppColors.textFieldColor),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  ),
            ).animate().fade(duration: .6.seconds, delay: .5.seconds),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 900,
              //  Expanded(
//!! i have to fix this ...if i remove it there is no space to add new stuff
              child: MyWidget(
                showCardFouced:
                    //!! we can make it as function  before the build ?
                    (BuildContext context, CreateNewTaskModel task) {
                  Navigator.push(
                      context,
                      PageTransition(
                        child: ExpandedCard(
                          //!! i need to add the color and chape to this widget
                          task: task,
                        ),
                        type: PageTransitionType.fade,
                      )
                      //? this appear a black material ><
                      // MaterialPageRoute(
                      //   builder: (context) => ExpandedCard(task: task),
                      // ),
                      );
                },
              ),
            ).animate().fade(duration: .7.seconds, delay: .6.seconds),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final Function(BuildContext, CreateNewTaskModel) showCardFouced;
  const MyWidget({Key? key, required this.showCardFouced}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
//? this data will came from back that just for testing ...
  final List<CreateNewTaskModel> allTasks = [
    CreateNewTaskModel(
        taskName: 'Task 1',
        taskDescription: 'Description 1',
        taskStatus: 'NEW',
        project_id: 1),
    CreateNewTaskModel(
        taskName: 'Task 2',
        taskDescription: 'Description 2',
        taskStatus: 'ON_PROGRESS',
        project_id: 1),
    CreateNewTaskModel(
        taskName: 'Task 3',
        taskDescription: 'Description 3',
        taskStatus: 'DONE',
        project_id: 1),
    CreateNewTaskModel(
        taskName: 'Task 4',
        taskDescription: 'Description 4',
        taskStatus: 'NEW',
        project_id: 1),
    CreateNewTaskModel(
        taskName: 'Task 5',
        taskDescription: 'Description 5',
        taskStatus: 'ON_PROGRESS',
        project_id: 1),
    CreateNewTaskModel(
        taskName: 'Task 6',
        taskDescription: 'Description 6',
        taskStatus: 'DONE',
        project_id: 1),
    CreateNewTaskModel(
        taskName: 'Task 7',
        taskDescription: 'Description 7',
        taskStatus: 'ON_PROGRESS',
        project_id: 1),
  ];

  @override
  Widget build(BuildContext context) {
    //?? we have to filtering the tasks by status ..

    List<CreateNewTaskModel> newTasks = allTasks
        .where((onlyNewtask) => onlyNewtask.taskStatus == "NEW")
        .toList();
    List<CreateNewTaskModel> onProgressTasks =
        allTasks.where((task) => task.taskStatus == "ON_PROGRESS").toList();
    List<CreateNewTaskModel> doneTasks =
        allTasks.where((task) => task.taskStatus == "DONE").toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DraggableColumn(
          key: UniqueKey(),
          // items: [
          //   ItemWidget('Item 1'),
          //   ItemWidget('Item 2'),
          //   ItemWidget('Item 3'),
          // ],
          widgetItems: newTasks
              .map((task) => ItemWidget(task, widget.showCardFouced))
              .toList(),
          status: "Backing",
          textColor: AppColors.backingTextColor,
          color: AppColors.cardPurpleColor,
        ),
        DraggableColumn(
          key: UniqueKey(),
          // items: [
          //   ItemWidget('Item 4'),
          //   ItemWidget('Item 5'),
          //   ItemWidget('Item 6'),
          // ],
          widgetItems: onProgressTasks
              .map((e) => ItemWidget(e, widget.showCardFouced))
              .toList(),
          status: "on progress",
          textColor: AppColors.progressTextColor,
          color: AppColors.cardApricotColor,
        ),
        DraggableColumn(
          key: UniqueKey(),
          //   items: [ItemWidget('item 7'), ItemWidget('item 8')],
          widgetItems: doneTasks
              .map((e) => ItemWidget(e, widget.showCardFouced))
              .toList(),
          status: "Done",
          textColor: AppColors.doneTextColor,
          color: AppColors.cardGreenColor,
        ),
      ],
    );
  }
}

class DraggableColumn extends StatefulWidget {
  final List<Widget> widgetItems;
  final Color color;
  final String status;
  final Color textColor;

  const DraggableColumn({
    Key? key,
    required this.widgetItems,
    required this.color,
    required this.status,
    required this.textColor,
  }) : super(key: key);

  @override
  _DraggableColumnState createState() => _DraggableColumnState();
}

class _DraggableColumnState extends State<DraggableColumn> {
  List<Widget> items = [];

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
      //!
      onAcceptWithDetails: (details) {
        setState(() {
          widget.widgetItems.remove(details.data);
          items.add(details.data);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Column(
//! we have to test the items if its empty or not in order to add placeholder widge
          // but we can design it better not to appeare
          children: items.isEmpty
              ? [
                  Container(
                    height: 100,
                    width: 100,
                    //color: widget.color.withOpacity(0.2),
                    child: Center(
                      child: Text('drop '),
                    ),
                  )
                ]
              : items
                  .map(
                    (item) => Draggable<Widget>(
                      data: item,
                      feedback: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            color: widget.color,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.status,
                                      style: TextStyle(color: widget.textColor),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.pest_control_outlined,
                                          color: widget.textColor,
                                        ))
                                  ],
                                ),
                                item,
                              ],
                            ),
                          )),
                      childWhenDragging: Container(),
                      onDragCompleted: () {
                        //!! maybe here we have to make a conditoin depends on the response of the update request .......
                        //! maybe if its return true so update the ui using setState bellow ,if it false do nothing
                        //! or in the onAccepteWithDetails??
                        setState(() {
                          //? this line in order not to add a copy of the items but to transformate
                          items.remove(item);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          color: widget.color,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.status,
                                    style: TextStyle(color: widget.textColor),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.pest_control_outlined,
                                      color: widget.textColor,
                                    ),
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

class ItemWidget extends StatelessWidget {
  final CreateNewTaskModel itemDescription;
  final Function(BuildContext, CreateNewTaskModel) onTap;
  const ItemWidget(this.itemDescription, this.onTap);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onDoubleTap: () => onTap(context, itemDescription),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: screenWidth * 0.2, //150,
        height: 73,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Center(
          child: Text(itemDescription.taskDescription),
        ),
      ),
    );
  }
}

class ExpandedCard extends StatelessWidget {
  final CreateNewTaskModel task;
  //final Color color
  //final String status
  //final Color text& icon color
  const ExpandedCard({Key? key, required this.task});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Stack(
        children: [
          Blur(
            blur: 5,
            blurColor: Colors.black.withOpacity(0.1),
            colorOpacity: 0.4,
            child: Container(
              width: screenWidth,
              height: screenHeight,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Center(
            child: Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                child: Card(
                  elevation: 8,
                  color: Colors.orange[100],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'i have to add this //' + task.taskName,
                            style: TextStyle(color: Colors.orange),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.pest_control_outlined,
                                color: Colors.orange,
                              ))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: screenWidth * 0.7, //150,
                        height: screenHeight * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(task.taskDescription),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
