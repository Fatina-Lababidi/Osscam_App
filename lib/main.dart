import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/app_bloc/app_bloc.dart';
import 'package:osscam/bloc/delete_project_bloc/delete_project_bloc.dart';
import 'package:osscam/core/config/bloc_observe.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/projects_pages/create_or_join_page.dart';
import 'package:osscam/pages/projects_pages/get_projects_page.dart';
import 'package:osscam/pages/start_pages/interance_page.dart';
import 'package:osscam/pages/auth_pages/login_page.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  init();
  runApp(const MyApp());
}

//bool isUpdate = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc()..add(CheckAppStatus()),
        ),
        BlocProvider<DeleteProjectBloc>(
          create: (context) => DeleteProjectBloc(),
        ),
      ],
      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppNavigator(),
      ),
    );
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is HeJoinApp) {
          return const CreateOrJoinPage();
        } else if (state is HeLoggedOut) {
          return LogInPage();
        } else if (state is HisFirstTime) {
          return const InterancePage();
        } else if (state is UseingApp) {
          return const GetProjectsPage();
        } else {
          return const Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.continerColor,),
            ),
          );
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  Future<void> _clearToken() async {
    config.get<SharedPreferences>().remove('token');
    // config.get<SharedPreferences>().clear();
    print('Token removed from SharedPreferences');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Clear SharedPreferences Example'),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                _clearToken();
              },
              child: Text('Clear Token')),
        ),
      ),
    );
  }
}


//sanata@gmail.com
