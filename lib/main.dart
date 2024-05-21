import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/app_bloc/app_bloc.dart';
import 'package:osscam/core/config/bloc_observe.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/pages/get_projects_page.dart';
import 'package:osscam/pages/interance_page.dart';
import 'package:osscam/pages/project_details_page.dart';

void main() {
  // A a = A(name: 'name', App: APP.COMPLETED.name);
  Bloc.observer = MyBlocObserver();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProjectDetailsPage()
      //  InterancePage(),
      ),
    );
  }
}
//log in email : sana20@gmail.com
//password:  ssssssss
// guscks@gmail.com
// 123456789
//sanaTa2024@gmail.com
