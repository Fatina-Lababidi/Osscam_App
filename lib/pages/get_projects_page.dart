import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/projects_bloc/projects_bloc.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/widgets/search_textField.dart';

class GetProjectsPage extends StatefulWidget {
  const GetProjectsPage({super.key});

  @override
  State<GetProjectsPage> createState() => _GetProjectsPageState();
}

class _GetProjectsPageState extends State<GetProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectsBloc()..add(GetProjects()),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
              if (state is SuccessGetProjects) {
                return Column(
                  children: [
                    SearchTextField(),
                    Container(
                      height: 500,
                      child: ListView.builder(
                        itemCount: state.projects.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         child: ProjectDetels(),
                              //         type: PageTransitionType.fade));
                            },
                            child: Container(
                              margin:const EdgeInsets.all(5),
                              height: 35,
                              color: AppColors.textCreateColor,
                              child: Text(state.projects[index].name),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else if (state is OfflineOnGetProjects) {
                return const Center(
                  child: Text('offline'),
                );
              } else if (state is ErrorGetProjects) {
                return const Center(
                  child: Text(
                    'Error',
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.continerColor,
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }
}
