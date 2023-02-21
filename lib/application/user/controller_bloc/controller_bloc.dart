import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:improsso/domain/general_domain/entities/completed_course_entitiy.dart';
import 'package:improsso/infrastructure/repositories/user_repository_impl.dart';

part 'controller_event.dart';
part 'controller_state.dart';

class ControllerBloc extends Bloc<ControllerEvent, ControllerState> {
  ControllerBloc() : super(ControllerInitial()) {
    on<UpdateUsernameEvent>((event, emit) async {
      UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
      await userRepositoryImpl
          .updateUsername(event.input)
          .then((failureOrUnit) {
        failureOrUnit.fold((failure) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                  "Ups, updating username gone wrong. Please try again!")));
          return emit(ControllerUpdateUsernameFailure());
        }, (unit) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("Username updated!")));
          return emit(ControllerUpdateUsernameSuccess());
        });
      });
    });

    on<UpdateCurrentUniversityEvent>((event, emit) async {
      UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
      await userRepositoryImpl
          .updateCurrentUniversity(event.input)
          .then((failureOrUnit) {
        failureOrUnit.fold((failure) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                  "Ups, updating university gone wrong. Please try again!")));
          return emit(ControllerUpdateCurrentUniversityFailure());
        }, (unit) {
          return emit(ControllerUpdateCurrentUniversitySuccess());
        });
      });
    });

    on<UpdateCurrentProgramEvent>((event, emit) async {
      UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
      await userRepositoryImpl
          .updateCurrentProgram(event.input)
          .then((failureOrUnit) {
        failureOrUnit.fold((failure) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              backgroundColor: Colors.redAccent,
              content:
                  Text("Ups, updating program gone wrong. Please try again!")));
          return emit(ControllerUpdateCurrentProgramFailure());
        }, (unit) {
          return emit(ControllerUpdateCurrentProgramSuccess());
        });
      });
    });

    on<AddCompletedCourseEvent>((event, emit) async {
      UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
      await userRepositoryImpl
          .addCompletedCourse(event.courseEntity)
          .then((failureOrUnit) {
        Navigator.of(event.context).popUntil((route) => route.isFirst);
        failureOrUnit.fold((failure) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              backgroundColor: Colors.redAccent,
              content:
                  Text("Ups, adding course gone wrong. Please try again!")));
          return emit(ControllerAddedCompletedCourseFailure());
        }, (unit) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("Course added!")));
          return emit(ControllerAddedCompletedCourseSuccess());
        });
      });
    });

    on<DeleteCompletedCourseEvent>((event, emit) async {
      UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
      await userRepositoryImpl
          .deleteCompletedCourse(event.courseEntity)
          .then((failureOrUnit) {
        Navigator.of(event.context).popUntil((route) => route.isFirst);
        failureOrUnit.fold((failure) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              backgroundColor: Colors.redAccent,
              content:
                  Text("Ups, deleting course gone wrong. Please try again!")));
          return emit(ControllerDeletedCompletedCourseFailure());
        }, (unit) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("Course deleted!")));
          return emit(ControllerDeletedCompletedCourseSuccess());
        });
      });
    });
  }
}
