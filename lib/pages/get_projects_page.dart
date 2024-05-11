import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/projects_bloc/projects_bloc.dart';
import 'package:osscam/core/resources/color.dart';

class GetProjectsPage extends StatelessWidget {
  const GetProjectsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //  // here we want to wrap the Scaffold with BlocProvider and Builder .. we cannot use the BlocBuilder without BlocProvider
    return BlocProvider(
      create: (context) => ProjectsBloc()..add(GetProjects()),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
              if (state is ErrorGetProjects) {
                return Center(
                  child: Text('Error'),
                );
              } else if (state is SuccessGetProjects) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "succes",
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      child: ListView.builder(
                          itemCount: state.projects.length,
                          itemBuilder: (context, index) =>
                              Text(state.projects[index].name)),
                    ),
                  ],
                );
              } else if (state is OfflineOnGetProjects) {
                return Center(
                  child: Text('Offline'),
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColors.continerColor,
                ));
              }
            },
          ),
        );
      }),
    );
  }
}
