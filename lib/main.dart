import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/bloc/app_bloc/app_bloc.dart';
import 'package:osscam/core/config/bloc_observe.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:osscam/pages/interance_page.dart';

void main() {
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
        home: InterancePage(),
      ),
    );
  }
}
//log in email : sana8@gmail.com 
//password:  ssssssss
// guscks@gmail.com
// 123456789