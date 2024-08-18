import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/pages/about.dart';
import 'package:todo_app/pages/todo_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
      routes: {
        '/homepage' : (context) => const TodoPage(),
        '/aboutpage' : (context) => const AboutPage()
      },

    );


  }
}
