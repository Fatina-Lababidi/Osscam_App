import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/adding_bugs_bloc/add_bugs_bloc.dart';
import 'package:osscam/bloc/comments_bloc/comments_bloc.dart';
// import 'package:osscam/bloc/get_bugs_by_tasks.dart/get_bugs_by_task_bloc.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/bugs_model/add_bugs_model.dart';
import 'package:osscam/model/comment_model/post_comment_model.dart';
import 'package:osscam/pages/handle_exception/error_page.dart';
import 'package:osscam/pages/handle_exception/offline_page.dart';
import 'package:osscam/pages/tasks/bugs_page.dart';
// import 'package:osscam/pages/projects_pages/getOneProject_page.dart';
// import 'package:osscam/widgets/app_textfield_login.dart';
import 'package:osscam/widgets/bugs_widget.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:osscam/widgets/project_details_widgets/projectNameWidget.dart';

class AddBugsPage extends StatefulWidget {
  AddBugsPage(
      {super.key,
      required this.bugId,
      required this.hasBugs,
      this.post,
      required this.taskId,
      required this.projectId,
      required this.projectName,
      required this.projectDescription});
  final int bugId;
  final bool hasBugs;
  final int taskId;
  final int projectId;
  final String projectName;
  final String projectDescription;
  final PostCommentsModel? post;
  @override
  State<AddBugsPage> createState() => _AddBugsPageState();
}

class _AddBugsPageState extends State<AddBugsPage> {
  bool isVisible = false;
  void changeVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  TextEditingController bugsController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AddBugsBloc>(
          create: (context) => AddBugsBloc(),
        ),
        BlocProvider(
          create: (context) => CommentsBloc(),
        ),
      ],
      child: BlocListener<AddBugsBloc, AddBugsState>(
        listener: (context, state) {
          if (state is SuccessAddBug) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                content: Text(
                  'Successful creating new bugs...',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: AppColors.cardGreenColor,
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.push(
                context,
                PageTransition(
                    child: BugsPage(
                        projectId: widget.projectId,
                        projectDescription: widget.projectDescription,
                        projectName: widget.projectName,
                        bugId: widget.bugId,
                        hasBugs: !(widget.hasBugs),
                        taskId: widget.taskId),
                    type: PageTransitionType.fade));
          } else if (state is ErrorAddBug) {
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
                    child: ErrorPage(
                      previousPage: AddBugsPage(
                          projectId: widget.projectId,
                          projectDescription: widget.projectDescription,
                          projectName: widget.projectName,
                          bugId: widget.bugId,
                          hasBugs: widget.hasBugs,
                          taskId: widget.taskId),
                    ),
                    type: PageTransitionType.fade));
          } else if (state is OfflineAddBug) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                      previousPage: AddBugsPage(
                          projectId: widget.projectId,
                          projectDescription: widget.projectDescription,
                          projectName: widget.projectName,
                          bugId: widget.bugId,
                          hasBugs: widget.hasBugs,
                          taskId: widget.taskId),
                    ),
                    type: PageTransitionType.fade));
          }
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.textFieldColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.buttonColor,
                  ),
                ),
              ),
              // SizedBox(
              //   height: screenHeight * 0.03,
              // ),
              BugsNameWidget(
                bugsId: widget.bugId,
                projectDescription: widget.projectDescription,
                projectId: widget.projectId,
                taskId: widget.taskId,
                hasBugs: widget.hasBugs,
                projectName: widget.projectName,
                name: "Bugs",
                icon: Icons.pest_control,
              ).animate().fade(duration: .3.seconds, delay: .3.seconds),
              const Divider(
                color: AppColors.continerColor,
              ).animate().fade(duration: .35.seconds, delay: .35.seconds),
              SizedBox(
                height: screenHeight * 0.07,
                child: const Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.cardGreenColor,
                      child: Text(
                        "n", //post.author[0]
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    title: Text(
                      "name", //post.author
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ).animate().fade(duration: .4.seconds, delay: .4.seconds),
              const Divider(
                color: AppColors.continerColor,
              ).animate().fade(duration: .45.seconds, delay: .45.seconds),
              SizedBox(
                height: screenHeight * 0.01,
              ),

              Center(
                child: Container(
                  width: screenWidth * 0.9, // 310,
                  height: screenHeight * 0.3, // 400,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: false,
                        cursorColor: AppColors.sendIconColor,
                        // style: TextStyle(color: AppColors.inputTextColor),
                        // cursorColor: AppColors.primaryColor,
                        maxLines: 6,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return "please enter bug";
                          }
                        },
                        controller: bugsController,
                        decoration: const InputDecoration(
                          hintText: "enter bug...",
                          hintStyle: TextStyle(fontSize: 20),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          border: InputBorder.none,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: BlocBuilder<AddBugsBloc, AddBugsState>(
                            builder: (context, state) {
                              if (state is AddBugsInitial) {
                                return SizedBox(
                                  height: screenHeight * 0.07,
                                  // width: screenWidth*0.16,
                                  child: IconButton(
                                      onPressed: () {
                                        if (bugsController.text.isNotEmpty) {
                                          //post the comments
                                          context.read<AddBugsBloc>().add(
                                              AddBug(
                                                  bug: AddingBugsModel(
                                                      title: 'testing',
                                                      description:
                                                          bugsController.text,
                                                      priority: 0,
                                                      taskId: widget.taskId)));
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.send_outlined,
                                        color: AppColors.sendIconColor,
                                      )),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ), //widget.comment
                ).animate().fade(duration: .5.seconds, delay: .5.seconds),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              // const Divider(
              //   color: AppColors.continerColor,
              // ),
              // InkWell(
              //   onTap: () {
              //     changeVisible();
              //   },
              //   child: Container(
              //     height: screenHeight * 0.02,
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 0.1),
              //       child: Center(
              //         child: (isVisible)
              //             ? const Icon(
              //                 Icons.arrow_drop_down,
              //                 color: AppColors.continerColor,
              //                 size: 17,
              //               )
              //             : const Icon(
              //                 Icons.arrow_drop_up,
              //                 color: AppColors.continerColor,
              //                 size: 17,
              //               ),
              //       ),
              //     ),
              //   ),
              // ),
              // Divider(
              //   color: AppColors.continerColor,
              // ),
              // Spacer(),
              // if (isVisible)
              //   Positioned(
              //     bottom: 0,
              //     left: 0,
              //     right: 0,
              //     child: Container(
              //       height: screenHeight * 0.1,
              //       color: AppColors.blackContainerColor,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             margin: EdgeInsets.all(10),
              //             decoration: BoxDecoration(
              //                 color: AppColors.blackTextFieldColor,
              //                 borderRadius: BorderRadius.circular(50)),
              //             // height: screenHeight * 0.05,
              //             width: screenWidth * 0.8,
              //             child: TextFormField(
              //               obscureText: false,
              //               cursorColor: AppColors.sendIconColor,
              //               maxLines: 2,
              //               controller: commentsController,
              //               decoration: const InputDecoration(
              //                 contentPadding: EdgeInsets.symmetric(
              //                     horizontal: 16, vertical: 16),
              //                 border: InputBorder.none,
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             height: screenHeight * 0.07,
              //             // width: screenWidth*0.16,
              //             child: BlocListener<CommentsBloc, CommentsState>(
              //               listener: (context, state) {
              //                 if (state is SuccessSendingComment) {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                       SnackBar(
              //                           content: Text('Success creating')));
              //                 } else if (state is ErrorPostComment) {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     SnackBar(
              //                       action: SnackBarAction(
              //                           label: "", onPressed: () {}),
              //                       content: const Text("Error creating"),
              //                       duration: Duration(seconds: 1),
              //                     ),
              //                   );
              //                   Navigator.push(
              //                       context,
              //                       PageTransition(
              //                           child: ErrorPage(
              //                             previousPage: AddBugsPage(
              //                                 projectId: widget.projectId,
              //                                 projectDescription:
              //                                     widget.projectDescription,
              //                                 projectName: widget.projectName,
              //                                 bugId: widget.bugId,
              //                                 hasBugs: widget.hasBugs,
              //                                 taskId: widget.taskId),
              //                           ),
              //                           type: PageTransitionType.fade));
              //                 } else if (state is OfflinePostComment) {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     SnackBar(
              //                       action: SnackBarAction(
              //                           label: "", onPressed: () {}),
              //                       content:
              //                           const Text("Offline while creating"),
              //                       duration: Duration(seconds: 1),
              //                     ),
              //                   );
              //                   Navigator.push(
              //                       context,
              //                       PageTransition(
              //                           child: OfflinePage(
              //                             previousPage: AddBugsPage(
              //                                 projectId: widget.projectId,
              //                                 projectDescription:
              //                                     widget.projectDescription,
              //                                 projectName: widget.projectName,
              //                                 bugId: widget.bugId,
              //                                 hasBugs: widget.hasBugs,
              //                                 taskId: widget.taskId),
              //                           ),
              //                           type: PageTransitionType.fade));
              //                 }
              //               },
              //               child: IconButton(
              //                   onPressed: () {
              //                     if (commentsController.text.isNotEmpty) {
              //                       //post the comments
              //                       context.read<CommentsBloc>().add(
              //                           SendComment(
              //                               comment: PostCommentsModel(
              //                                   comment:
              //                                       commentsController.text,
              //                                   bugId: widget.bugId)));
              //                     }
              //                   },
              //                   icon: Icon(
              //                     Icons.send_outlined,
              //                     color: AppColors.sendIconColor,
              //                   )),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
            ]),
          ),
        ),
      ),
    );
  }
}
