part of 'studies_bloc.dart';

abstract class StudiesState {}

class StudiesInitial extends StudiesState {}

class StudiesLoading extends StudiesState {}

class StudiesFailure extends StudiesState {}

class StudiesSuccess extends StudiesState {
  final Map<String, String> universities;
  final Map<String, String> programs;
  StudiesSuccess({required this.universities, required this.programs});
}
