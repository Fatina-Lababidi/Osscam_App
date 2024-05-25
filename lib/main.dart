import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/app_bloc/app_bloc.dart';
import 'package:osscam/bloc/delete_project_bloc/delete_project_bloc.dart';
import 'package:osscam/core/config/bloc_observe.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/core/resources/color.dart';
import 'package:osscam/pages/create_or_join_page.dart';
import 'package:osscam/pages/get_projects_page.dart';
import 'package:osscam/pages/interance_page.dart';
import 'package:osscam/pages/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // A a = A(name: 'name', App: APP.COMPLETED.name);
  Bloc.observer = MyBlocObserver();
  init();
  runApp(MyApp());
}

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state is HeJoinApp) {
              Navigator.push(
                  context,
                  PageTransition(
                      child: CreateOrJoinPage(),
                      type: PageTransitionType.fade));
            } else if (state is HeLoggedOut) {
              Navigator.push(
                  context,
                  PageTransition(
                      child: LogInPage(), type: PageTransitionType.fade));
            } else if (state is HisFirstTime) {
              Navigator.push(
                  context,
                  PageTransition(
                      child: InterancePage(), type: PageTransitionType.fade));
            } else if (state is UseingApp) {
              Navigator.push(
                  context,
                  PageTransition(
                      child: GetProjectsPage(), type: PageTransitionType.fade));
            }
          }, //!! we have to fix this
          child: Container(
            color: AppColors.primaryColor,
          ),
        ),

        // home: BlocBuilder<AppBloc, AppState>(
        //   builder: (context, state) {
        //     if (state is HeSigendUp || state is HeLoggedIn) {
        //       return GetProjectsPage();
        //     } else if (state is HeLoggedOut) {
        //       return LogInPage();
        //     } else {
        //       return
        //           //ProjectsLoadingWidget();
        //           // CreateNewProjectPage();
        //           GetProjectsPage();
        //       // const InterancePage();
        //     }
        //   },
        // ),
        // GetProjectsPage(),
      ),
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
//ff22@gmail.com, ffffffffff


//!! it give me this error after log in :
/*
[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Bad state: add(LoggedIn) was called without a registered event handler.
Make sure to register a handler via on<LoggedIn>((event, emit) {...})
#0      Bloc.add.<anonymous closure> (package:bloc/src/bloc.dart:91:9)
#1      Bloc.add (package:bloc/src/bloc.dart:97:6)

*/


//! service of the update task

//! get all projects media query

//! log in exeption

//! make the details page dialogs un tapped in order not to pop twice


//sanaTa@gmail.com