import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/delete_project_bloc/delete_project_bloc.dart';
import 'package:osscam/bloc/project_task_bloc/project_task_bloc.dart';
import 'package:osscam/bloc/projects_bloc/projects_bloc.dart';
import 'package:osscam/core/resources/asset.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/model/get_projects_model.dart';
import 'package:osscam/pages/error_page.dart';
import 'package:osscam/pages/offline_page.dart';
import 'package:osscam/pages/project_details_page.dart';
import 'package:osscam/widgets/project_loading_widget.dart';
import 'package:osscam/widgets/search_textField.dart';
import 'package:page_transition/page_transition.dart';

class GetProjectsPage extends StatefulWidget {
  const GetProjectsPage({super.key});

  @override
  State<GetProjectsPage> createState() => _GetProjectsPageState();
}

// List<ProjectsModel>? projects = response.data ;
ValueNotifier<List<ProjectsModel>> result = ValueNotifier([]);

class _GetProjectsPageState extends State<GetProjectsPage> {
  // @override
  // void dispose() {
  //   result.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProjectsBloc()..add(GetProjects()),
        ),
        BlocProvider(
          create: (context) => ProjectTaskBloc(),
        ),
        BlocProvider<DeleteProjectBloc>(
          create: (context) => DeleteProjectBloc(),
        )
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: BlocConsumer<ProjectsBloc, ProjectsState>(
            listener: (context, state) {
              if (state is ErrorGetProjects) {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const ErrorPage(
                      previousPage: GetProjectsPage(),
                    ),
                    type: PageTransitionType.fade,
                  ),
                );
              } else if (state is OfflineOnGetProjects) {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const OfflinePage(
                      previousPage: GetProjectsPage(),
                    ),
                    type: PageTransitionType.fade,
                  ),
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<ProjectsBloc, ProjectsState>(
                builder: (context, state) {
                  if (state is SuccessGetProjects) {
                    print(result);
                    return Column(
                      children: [
                        SearchTextField(
                          data: state.projects,
                        ),
                        ValueListenableBuilder(
                            valueListenable: result,
                            builder: (context, value, _) {
                              return Expanded(
                                child: (value.length != 0)
                                    ? Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: ListView.builder(
                                          itemCount: value.length,
                                          itemBuilder: (context, ind) {
                                            return GestureDetector(
                                              onTap: () {
                                                result.value = [];
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child: ProjectDetailsPage(
                                                      projectId: value[ind].id,
                                                      projectName:
                                                          value[ind].name,
                                                      projectDescription:
                                                          value[ind]
                                                              .description,
                                                    ),
                                                    type:
                                                        PageTransitionType.fade,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.continerColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                margin: const EdgeInsets.all(5),
                                                height:
                                                    screenHeight * 0.13, //105,
                                                width: screenWidth * 0.3, //317,
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          width: screenWidth *
                                                              0.25, //135,
                                                          height: screenHeight *
                                                              0.12, //105,
                                                          child: Image(
                                                            fit: BoxFit.cover,
                                                            image: const AssetImage(
                                                                AppImages
                                                                    .vector_image),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Text(
                                                            value[ind]
                                                                .id
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Frijole',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Text(
                                                            'Project name : ' +
                                                                value[ind]
                                                                    .name
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .inputTextColor),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ).animate().scaleXY(
                                                  delay: Duration(
                                                      milliseconds:
                                                          50 + (ind * 10)),
                                                  duration: Duration(
                                                      milliseconds:
                                                          50 + (ind * 10))),
                                            );
                                          },
                                        ))
                                    : Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: ListView.builder(
                                          itemCount: state.projects.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                result.value = [];
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child:
                                                            ProjectDetailsPage(
                                                          projectId: state
                                                              .projects[index]
                                                              .id,
                                                          projectName: state
                                                              .projects[index]
                                                              .name,
                                                          projectDescription:
                                                              state
                                                                  .projects[
                                                                      index]
                                                                  .description,
                                                        ),
                                                        type: PageTransitionType
                                                            .fade));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.continerColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                margin: const EdgeInsets.all(5),
                                                height:
                                                    screenHeight * 0.13, //105,
                                                width: screenWidth * 0.3, //317,
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          width: screenWidth *
                                                              0.35, //135,
                                                          height: screenHeight *
                                                              0.13, //105,
                                                          child: const Image(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                AppImages
                                                                    .vector_image),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Text(
                                                            state
                                                                .projects[index]
                                                                .id
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Frijole',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Text(
                                                            'Project name : ' +
                                                                state
                                                                    .projects[
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .inputTextColor),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ).animate().scaleXY(
                                                  delay: Duration(
                                                      milliseconds:
                                                          200 + (index * 10)),
                                                  duration: Duration(
                                                      milliseconds:
                                                          100 + (index * 10))),
                                            );
                                          },
                                        ),
                                      ),
                              );
                            })
                      ],
                    );
                  } else {
                    return const ProjectsLoadingWidget();
                  }
                },
              );
            },
          ),
        );
      }),
    );
  }
}


//! testing :


class CircularBorderPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;

  CircularBorderPainter({
    required this.fillColor,
    required this.borderColor,
    required this.borderRadius,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    canvas.drawRRect(rrect, paint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawRRect(rrect, borderPaint);

    final linePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;  // Add this to round the ends of the line

    final linePath = Path();
    linePath.moveTo(size.width * 0.75, 0);
    linePath.lineTo(0, size.height-5);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



class CustomPaintedContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color fillColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;

  const CustomPaintedContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.fillColor,
    required this.borderColor,
    required this.borderRadius,
    required this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularBorderPainter(
        fillColor: fillColor,
        borderColor: borderColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth,
      ),
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}

class YourWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomPaintedContainer(
            height: screenHeight * 0.13, // Adjust the height as needed
            width: screenWidth * 0.3, // Adjust the width as needed
            fillColor: Colors.blue, // Replace with your fill color
            borderColor: Colors.red, // Replace with your border color
            borderRadius: 10,
            borderWidth: 2, // Adjust the border width as needed
          ),
        ),
      ),
    );
  }
}
