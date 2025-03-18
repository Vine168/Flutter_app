// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_app/W6/EX-1-START-CODE/providers/courses_provider.dart';
import 'package:flutter_app/W6/EX-1-START-CODE/repositories/courses_mock_repository.dart';
import 'package:flutter_app/W6/EX-1-START-CODE/screens/course_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoursesProvider(CoursesMockRepository()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CoursesListScreen(),
      ),
    );
  }
}