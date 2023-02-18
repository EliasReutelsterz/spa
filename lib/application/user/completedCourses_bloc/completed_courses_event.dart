part of 'completed_courses_bloc.dart';

@immutable
abstract class CompletedCoursesEvent {}

class StreamAllCompletedCourses extends CompletedCoursesEvent {}

class CompletedCoursesUpdated extends CompletedCoursesEvent {
  final Either<Failure, Map<String, CourseEntity>> failureOrMapOfCourseEntity;
  CompletedCoursesUpdated({required this.failureOrMapOfCourseEntity});
}
