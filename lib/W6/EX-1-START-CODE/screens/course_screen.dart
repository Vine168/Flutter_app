
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/courses_provider.dart';
import 'course_score_form.dart';

const Color mainColor = Colors.blue;
class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.courseId});
  final String courseId;

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CoursesProvider>(context);
    final course = provider.getCourseFor(courseId);

    if (course == null) {
      return Scaffold(body: Center(child: Text('Course not found')));
    }

    Widget content = const Center(child: Text('No Scores added yet.'));
    if (course.scores.isNotEmpty) {
      content = ListView.builder(
        itemCount: course.scores.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(course.scores[index].studentName),
          trailing: Text(
            course.scores[index].studentScore.toString(),
            style: TextStyle(
              color: scoreColor(course.scores[index].studentScore),
              fontSize: 15,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          course.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => CourseScoreForm(courseId: courseId)),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}