part of 'controller_bloc.dart';

abstract class ControllerState {}

class ControllerInitial extends ControllerState {}

class ControllerUpdateUsernameSuccess extends ControllerState {}

class ControllerUpdateUsernameFailure extends ControllerState {}

class ControllerUpdateCurrentUniversitySuccess extends ControllerState {}

class ControllerUpdateCurrentUniversityFailure extends ControllerState {}

class ControllerUpdateCurrentProgramSuccess extends ControllerState {}

class ControllerUpdateCurrentProgramFailure extends ControllerState {}

class ControllerAddedCompletedCourseSuccess extends ControllerState {}

class ControllerAddedCompletedCourseFailure extends ControllerState {}
