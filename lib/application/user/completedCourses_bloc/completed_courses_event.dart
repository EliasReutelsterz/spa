part of 'completed_courses_bloc.dart';

@immutable
abstract class CompletedCoursesEvent {}

class StreamAllCompletedCourses extends CompletedCoursesEvent {}

class CompletedCoursesUpdated extends CompletedCoursesEvent {
  final Either<Failure, Map<String, CompletedCourseEntity>>
      failureOrMapOfCourseEntity;
  CompletedCoursesUpdated({required this.failureOrMapOfCourseEntity});
}
