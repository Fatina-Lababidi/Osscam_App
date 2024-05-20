import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/app_bloc/app_bloc.dart';
import 'package:osscam/core/config/bloc_observe.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/pages/create_or_join_page.dart';
import 'package:osscam/pages/get_projects_page.dart';
import 'package:osscam/pages/interance_page.dart';
import 'package:osscam/pages/login_page.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc()..add(CheckAppStatus()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
             if (state is HeSigendUp || state is HeLoggedIn) {
              return GetProjectsPage();
                
               } else if (state is HeLoggedOut) {
                 return LogInPage();

               } else {
                 return const InterancePage();
               }
            // return InterancePage();
          },
        ),
        // GetProjectsPage(),
      ),
    );
  }
}
//log in email : sana8@gmail.com 
//password:  ssssssss
// guscks@gmail.com
// 123456789