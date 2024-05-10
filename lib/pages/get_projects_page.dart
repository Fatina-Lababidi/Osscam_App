import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/projects_bloc/projects_bloc.dart';
import 'package:osscam/core/resources/color.dart';

class GetProjectsPage extends StatelessWidget {
  const GetProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //context.read<ProjectsBloc>().add(GetProjects());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocBuilder<ProjectsBloc, ProjectsState>(
        builder: (context, state) {
          if (state is ErrorGetProjects) {
            return Center(
              child: Text('Error'),
            );
          } else if (state is SuccessGetProjects) {
            return ListView.builder(
                itemCount: state.projects.length,
                itemBuilder: (context, index) =>
                    Text(state.projects[index].name));
          } else if (state is OfflineOnGetProjects) {
            return Center(
              child: Text('Offline'),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
