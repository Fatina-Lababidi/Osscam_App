import 'package:flutter/material.dart';
import 'package:osscam/config.dart';
import 'package:osscam/pages/create_or_join_page.dart';
import 'package:osscam/pages/interance_page.dart';
import 'package:osscam/pages/login_page.dart';



void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      LogInPage(),
       //CreateOrJoinPage()
      //InterancePage(),
    );
  }
}
