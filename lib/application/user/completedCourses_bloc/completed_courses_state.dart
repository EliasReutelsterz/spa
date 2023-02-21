part of 'completed_courses_bloc.dart';

@immutable
abstract class CompletedCoursesState {}

class CompletedCoursesInitial extends CompletedCoursesState {}

class CompletedCoursesLoading extends CompletedCoursesState {}

class CompletedCoursesSuccess extends CompletedCoursesState {
  final Map<String, CompletedCourseEntity> courses;
  CompletedCoursesSuccess({required this.courses});
}

class CompletedCoursesFailure extends CompletedCoursesState {}
