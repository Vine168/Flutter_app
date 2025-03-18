
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/courses_provider.dart';
import 'course_screen.dart';

const Color mainColor = Colors.blue;

class CoursesListScreen extends StatelessWidget {
  const CoursesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CoursesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: provider.courses.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: Key(provider.courses[index].id),
          child: CourseTile(
            course: provider.courses[index],
            onEdit: (course) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => CourseScreen(courseId: course.id),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final Function(Course) onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average: $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            onTap: () => onEdit(course),
            title: Text(course.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(numberText), Text(averageText)],
            ),
          ),
        ),
      ),
    );
  }
}