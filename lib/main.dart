import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osscam/core/config/bloc_observe.dart';
import 'package:osscam/core/config/dependency_injection.dart';
// ignore: unused_import
import 'package:osscam/pages/create_or_join_page.dart';
// ignore: unused_import
import 'package:osscam/pages/interance_page.dart';
// ignore: unused_import
import 'package:osscam/pages/login_page.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: //LogInPage(),
          //  CreateOrJoinPage()
          InterancePage(),
    );
  }
}
//log in email : sana8@gmail.com 
//password:  ssssssss