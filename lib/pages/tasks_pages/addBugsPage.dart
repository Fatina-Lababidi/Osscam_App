import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/get_bugs_by_tasks.dart/get_bugs_by_task_bloc.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/comment_model/post_comment_model.dart';
// import 'package:osscam/pages/projects_pages/getOneProject_page.dart';
// import 'package:osscam/widgets/app_textfield_login.dart';
import 'package:osscam/widgets/bugs_widget.dart';
// import 'package:osscam/widgets/project_details_widgets/projectNameWidget.dart';

class AddBugsPage extends StatefulWidget {
  AddBugsPage(
      {super.key,
      required this.bugId,
      required this.hasBugs,
      this.post,
      required this.taskId});
  final int bugId;
  final bool hasBugs;
  final int taskId;
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

  TextEditingController bugs = TextEditingController();
  TextEditingController comments = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return BlocProvider<GetBugsByTaskBloc>(
      create: (context) =>
          GetBugsByTaskBloc()..add(GetBugs(taskId: widget.taskId)),
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
                    ),),
            // SizedBox(
            //   height: screenHeight * 0.03,
            // ),
            BugsNameWidget(
              name: "Bugs",
              icon: Icons.pest_control,
            ).animate().fade(duration: .3.seconds, delay: .2.seconds),
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
                child: TextFormField(
                  obscureText: false,
                  cursorColor: AppColors.sendIconColor,
                  // style: TextStyle(color: AppColors.inputTextColor),
                  // cursorColor: AppColors.primaryColor,
                  maxLines: 12,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "please enter bug";
                    }
                  },
                  controller: bugs,
                  decoration: const InputDecoration(
                    hintText: "enter bug...",
                    hintStyle: const TextStyle(fontSize: 20),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    border: InputBorder.none,
                  ),
                ), //widget.comment
              ),
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
                    child: (isVisible)
                        ? const Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.continerColor,
                            size: 17,
                          )
                        : const Icon(
                            Icons.arrow_drop_up,
                            color: AppColors.continerColor,
                            size: 17,
                          ),
                  ),
                ),
              ),
            ),
            Divider(
              color: AppColors.continerColor,
            ),
            Spacer(),
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
        ),
      ),
    );
  }
}
