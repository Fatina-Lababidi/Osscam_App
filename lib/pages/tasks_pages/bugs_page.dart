import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/comments_bloc/comments_bloc.dart';
import 'package:osscam/bloc/get_bugs_by_tasks.dart/get_bugs_by_task_bloc.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/comment_model/post_comment_model.dart';
import 'package:osscam/pages/handle_exception_pages/error_page.dart';
import 'package:osscam/pages/handle_exception_pages/offline_page.dart';
import 'package:osscam/pages/tasks_pages/project_details_page.dart';
// import 'package:osscam/widgets/app_textfield_login.dart';
import 'package:osscam/widgets/bugs_widget.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:osscam/widgets/project_details_widgets/projectNameWidget.dart';

class BugsPage extends StatefulWidget {
  BugsPage(
      {super.key,
      required this.bugId,
      required this.hasBugs,
      this.post,
      // this.details,
      required this.taskId});
  final int bugId;
  final bool hasBugs;
  final int taskId;
  final PostCommentsModel? post;
  // final ProjectDetailsPage? details;
  @override
  State<BugsPage> createState() => _BugsPageState();
}

class _BugsPageState extends State<BugsPage> {
  bool isVisible = false;
  void changeVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  void dispose() {
    bugsController.dispose();
    commentsController.dispose();
    super.dispose();
  }

  // List<PostCommentsModel> commentsList = [];
  // void SendComment() {
  //   setState(() {
  //     commentsList.insert(0, PostCommentsModel(
  //       comment: comments.text,
  //       bugId: widget.bugId,
  //     ));

  //     commentsList
  //         .add(PostCommentsModel(comment: comments.text, bugId: widget.bugId));
  //         context.read<CommentsBloc>().add(SendComment);
  //     bugs.clear();
  //   });
  // }

  TextEditingController bugsController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return MultiBlocProvider(
      providers: [
        BlocProvider<GetBugsByTaskBloc>(
          create: (context) =>
              GetBugsByTaskBloc()..add(GetBugs(taskId: widget.taskId)),
        ),
        BlocProvider<CommentsBloc>(
          create: (context) => CommentsBloc(),
        ),
      ],
      child: Scaffold(
        body: BlocListener<CommentsBloc, CommentsState>(
          listener: (context, state) {
            if (state is SuccessSendingComment) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Success creating')));
              Navigator.push(
                  context,
                  PageTransition(
                      child: BugsPage(
                        bugId: widget.bugId,
                        hasBugs: widget.hasBugs,
                        post: widget.post,
                        taskId: widget.taskId,
                      ),
                      type: PageTransitionType.fade));
            } else if (state is OfflinePostComment) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  action: SnackBarAction(label: "", onPressed: () {}),
                  content: const Text("Offline while creating"),
                  duration: Duration(seconds: 1),
                ),
              );
              Navigator.push(
                  context,
                  PageTransition(
                      child: OfflinePage(
                          previousPage: BugsPage(
                        bugId: widget.bugId,
                        hasBugs: widget.hasBugs,
                        post: widget.post,
                        taskId: widget.taskId,
                      )),
                      type: PageTransitionType.fade));
            } else if (state is ErrorPostComment) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  action: SnackBarAction(label: "", onPressed: () {}),
                  content: const Text("Error creating"),
                  duration: Duration(seconds: 1),
                ),
              );
              Navigator.push(
                  context,
                  PageTransition(
                      child: ErrorPage(
                        previousPage: BugsPage(
                          bugId: widget.bugId,
                          hasBugs: widget.hasBugs,
                          post: widget.post,
                          taskId: widget.taskId,
                        ),
                      ),
                      type: PageTransitionType.fade));
            }
          },
          child: BlocBuilder<GetBugsByTaskBloc, GetBugsByTaskState>(
            builder: (context, state) {
              if (state is SuccessGetBugs) {
                return PageView.builder(
                    itemCount: state.bugs.length,
                    itemBuilder: (context, indexPage) {
                      final bugs = state.bugs[indexPage];
                      return Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.textFieldColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                        child: Stack(
                          children: [
                            Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                        //               Navigator.push(
                        // context,
                        // PageTransition(
                        //     child: ProjectDetailsPage(projectDescription: widget., projectId: null, projectName: '',),
                        //     type: PageTransitionType.fade)); 
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.buttonColor,
                                  ),
                                ),
                              ),
                              BugsNameWidget(
                                name: "Bugs",
                                icon: Icons.pest_control,
                              ).animate().fade(
                                  duration: .3.seconds, delay: .2.seconds),
                              const Divider(
                                color: AppColors.continerColor,
                              ),
                              Container(
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
                              ),
                              const Divider(
                                color: AppColors.continerColor,
                              ),
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
                                    child:
                                        // (widget.hasBugs)
                                        //     ?
                                        Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, left: 16),
                                      child: Text(bugs.description),
                                    )),
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              const Divider(
                                color: AppColors.continerColor,
                              ),
                              InkWell(
                                onTap: () {
                                  changeVisible();
                                },
                                child: Container(
                                  height: screenHeight * 0.02,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0.1),
                                    child: Center(
                                        child: Icon(
                                      isVisible
                                          ? Icons.arrow_drop_up
                                          : Icons.arrow_drop_down,
                                      color: AppColors.continerColor,
                                      size: 17,
                                    )),
                                  ),
                                ),
                              ),
                              Divider(
                                color: AppColors.continerColor,
                              ),
                              // Spacer(),
                              if (isVisible)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 90),
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: bugs.comments.length,
                                      itemBuilder: (context, index) {
                                        final comment = bugs.comments[index];
                                        
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: screenWidth * 0.6,
                                            height: screenHeight * 0.1,
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .blackTextFieldColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                comment.comment,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              // SizedBox(height: 200,)
                              // Container(color: Colors.amber,),
                              // Container(
                              //   child: ListView(

                              //     children: [
                              //       Container(color: AppColors.bugsButtonColor,height: 10,),
                              //       Container(color: AppColors.bugsButtonColor,height: 10,),
                              //       Container(color: AppColors.bugsButtonColor,height: 10,)
                              //     ],
                              //   ),
                              // ),
                              // Container(color: Colors.amber,height: 6,),
                              // ListView.builder(itemBuilder:(context, index) {
                              //   (isVisible)? Container(height: 5,width: 6,):Container(color: Colors.amber,);

                              // },
                              // itemCount: 5,)
                              // SizedBox(height:screenHeight*0.0001 ,),
                              // Container(
                              //   height: screenHeight*0.2,
                              //   decoration: BoxDecoration(
                              //     color: AppColors.blackContainerColor
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         decoration: BoxDecoration(
                              //         color: AppColors.blackTextFieldColor,
                              //         borderRadius: BorderRadius.circular(50)
                              //         ),
                              //         child: TextField(

                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ]),
                            if (isVisible)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: screenHeight * 0.1,
                                  color: AppColors.blackContainerColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color:
                                                AppColors.blackTextFieldColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        // height: screenHeight * 0.05,
                                        width: screenWidth * 0.8,
                                        child: TextFormField(
                                          obscureText: false,
                                          cursorColor: AppColors.sendIconColor,
                                          // style: TextStyle(color: AppColors.inputTextColor),
                                          // cursorColor: AppColors.primaryColor,
                                          maxLines: 2,
                                          // validator: (value) {
                                          //   if (value!.isNotEmpty) {
                                          //     return null;
                                          //   } else {
                                          //     return "please enter comment";
                                          //   }
                                          // },
                                          controller: commentsController,
                                          decoration: const InputDecoration(
                                            // hintText: "enter bug...",
                                            // hintStyle: const TextStyle(fontSize: 20),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 16),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                        // Text(
                                        //   'hello ',
                                        //   style: TextStyle(color: Colors.white),
                                        // ),
                                      ),
                                      BlocBuilder<CommentsBloc, CommentsState>(
                                        builder: (context, state) {
                                          if (state is CommentsInitial) {
                                            return SizedBox(
                                              height: screenHeight * 0.07,
                                              // width: screenWidth*0.16,
                                              child: IconButton(
                                                  onPressed: () {
                                                    if (bugsController
                                                        .text.isNotEmpty) {
                                                      //post the comments
                                                      context
                                                          .read<CommentsBloc>()
                                                          .add(SendComment(
                                                              comment: PostCommentsModel(
                                                                  comment:
                                                                      commentsController
                                                                          .text,
                                                                  bugId: widget
                                                                      .bugId)));
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.send_outlined,
                                                    color:
                                                        AppColors.sendIconColor,
                                                  )),
                                            );
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    });
              } else {
                return Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.textFieldColor
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    )));
              }
            },
          ),
        ),
      ),
    );
  }
}
