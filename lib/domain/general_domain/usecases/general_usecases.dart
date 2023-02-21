import 'package:flutter/material.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/domain/general_domain/entities/completed_course_entitiy.dart';
import 'package:improsso/domain/general_domain/entities/general_course_entity.dart';
import 'package:improsso/domain/general_domain/entities/user_entity.dart';
import 'package:improsso/presentation/courses/buttons/add_selected_course_button.dart';

class GeneralUsecases {
  List<Widget> getListForAddCourses(
    Map<String, GeneralCourseEntity> courses,
    Map<String, CompletedCourseEntity> completedCourses,
    ControllerBloc controllerbloc,
  ) {
    for (String completedCourse in completedCourses.keys) {
      courses.remove(completedCourse);
    }
    List<Widget> list = courses.keys
        .map((key) => AddSelectedCourseButton(
              course: courses[key]!,
              courseId: key,
              controllerBloc: controllerbloc,
            ))
        .toList();
    return list;
  }
}
