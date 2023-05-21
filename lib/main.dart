import 'package:flutter/material.dart';
import 'package:learniverse/lesson/ui/lesson_edit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learniverse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const LessonEditScreen(),
    );
  }
}
