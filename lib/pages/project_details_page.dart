// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:osscam/widgets/project_details_widgets/expandedCardWidget.dart';
import 'package:osscam/widgets/project_details_widgets/myWidget.dart';
import 'package:osscam/widgets/project_details_widgets/projectDecriptionWidget.dart';
import 'package:osscam/widgets/project_details_widgets/projectNameWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/create_new_task.dart';
// /! this page will take an object from the privous page in order to appear only the tasks of the taped continer?
//! //already the data of this page will apear after we tap on the continer it will take the id of the project in order to show its tasks

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

  void _showCardExpanded(
      BuildContext context, CreateNewTaskModel task, Color color,Color textColor,String status) {
    Navigator.push(
        context,
        PageTransition(
          child: ExpandedCard(
            //!! i need to add the color and chape to this widget
            task: task,
            color: color,
            textAndIconColor:textColor,
            status:status,
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
            projectNameWidget()
                .animate()
                .fade(duration: .3.seconds, delay: .2.seconds),
            ProjectDescriptionWidget(
              text: text,
              lessText: lessText,
              isExpanded: _isExpanded,
              changeContainerExpanded: _changeContainerExpanded,
            ),
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
                    (BuildContext context, CreateNewTaskModel task,
                        Color color,Color textColor,String status) {
                  _showCardExpanded(context, task, color,textColor,status);
                },
              ),
            ).animate().fade(duration: .7.seconds, delay: .6.seconds),
          ],
        ),
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

