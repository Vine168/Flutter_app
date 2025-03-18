import '../models/course.dart';

class CoursesRepository {
  final List<Course> _Courses = [];

  List<Course> getCourses() => _Courses;

  void addCourse(Course course) {
    _Courses.add(course);
  }

  void addScore(String courseId, CourseScore score) {
    final course = _courses.firstWhere((course) => course.name == courseId);
    course.addScore(score);
  }
}
