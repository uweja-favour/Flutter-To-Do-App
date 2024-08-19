import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/pages/about.dart';
import 'package:todo_app/pages/signup_page.dart';
import 'package:todo_app/pages/todo_page.dart';
import 'package:todo_app/pages/login_page.dart';

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
      home: const LoginPage(),
      routes: {
        '/homepage' : (context) => const TodoPage(),
        '/aboutpage' : (context) => const AboutPage(),
        '/loginpage' : (context) => const LoginPage(),
        '/signuppage': (context) => const SignupPage(),

      },

    );


  }
}
