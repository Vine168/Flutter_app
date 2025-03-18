
import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/courses_repository.dart';

class CoursesProvider with ChangeNotifier {
  final CoursesRepository _repository;
  List<Course> _courses = [];
  CoursesProvider(this._repository) {
    _courses = _repository.getCourses();
  }

  List<Course> get courses => _courses;
  Course? getCourseFor(String id) {
    return _courses.firstWhere((course) => course.id == id, orElse: () => null as Course);
  }
  void addScore(String courseId, CourseScore score) {
    _repository.addScore(courseId, score);
    notifyListeners(); // Notify listeners to update UI
  }
}