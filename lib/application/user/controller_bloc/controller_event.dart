part of 'controller_bloc.dart';

abstract class ControllerEvent {}

class UpdateUsernameEvent extends ControllerEvent {
  final dynamic context;
  final String input;
  UpdateUsernameEvent({required this.context, required this.input});
}

class UpdateCurrentUniversityEvent extends ControllerEvent {
  final dynamic context;
  final String input;
  UpdateCurrentUniversityEvent({required this.context, required this.input});
}

class UpdateCurrentProgramEvent extends ControllerEvent {
  final dynamic context;
  final String input;
  UpdateCurrentProgramEvent({required this.context, required this.input});
}

class AddCompletedCourseEvent extends ControllerEvent {
  final dynamic context;
  final CourseEntity courseEntity;
  AddCompletedCourseEvent({required this.context, required this.courseEntity});
}
