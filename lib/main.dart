import 'package:flutter/material.dart';
import 'package:osscam/config.dart';
import 'package:osscam/pages/interance_page.dart';



void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InterancePage(), 
    );
  }
}