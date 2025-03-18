
import '../models/course.dart';

abstract class CoursesRepository {
  List<Course> getCourses();
  void addScore(String courseId, CourseScore score);
}