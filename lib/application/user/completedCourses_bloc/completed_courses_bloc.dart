import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:improsso/domain/general_domain/entities/completed_course_entitiy.dart';
import 'package:improsso/domain/general_domain/failures/failures.dart';
import 'package:improsso/infrastructure/repositories/user_repository_impl.dart';
import 'package:meta/meta.dart';

part 'completed_courses_event.dart';
part 'completed_courses_state.dart';

class CompletedCoursesBloc
    extends Bloc<CompletedCoursesEvent, CompletedCoursesState> {
  StreamSubscription<Either<Failure, Map<String, CompletedCourseEntity>>>?
      _userdataStreamSub;
  CompletedCoursesBloc() : super(CompletedCoursesInitial()) {
    on<CompletedCoursesEvent>((event, emit) async {
      await _userdataStreamSub?.cancel();
      UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
      _userdataStreamSub = await userRepositoryImpl
          .getCompletedCourses()
          .listen((failureOrMapOfCourseEntities) async {
        return add(CompletedCoursesUpdated(
            failureOrMapOfCourseEntity: failureOrMapOfCourseEntities));
      });
    });
    on<CompletedCoursesUpdated>((event, emit) {
      event.failureOrMapOfCourseEntity.fold(
          (failure) => emit(CompletedCoursesFailure()),
          (mapOfCourseEntities) =>
              emit(CompletedCoursesSuccess(courses: mapOfCourseEntities)));
    });
  }
}
