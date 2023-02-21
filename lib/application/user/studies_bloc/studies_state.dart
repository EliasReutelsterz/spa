part of 'studies_bloc.dart';

abstract class StudiesState {}

class StudiesInitial extends StudiesState {}

class StudiesLoading extends StudiesState {}

class StudiesFailure extends StudiesState {}

class StudiesSuccess extends StudiesState {
  final Map<String, UniEntity> universities;
  final Map<String, ProgramEntity> programs;
  final Map<String, GeneralCourseEntity> courses;
  StudiesSuccess(
      {required this.universities,
      required this.programs,
      required this.courses});
}
