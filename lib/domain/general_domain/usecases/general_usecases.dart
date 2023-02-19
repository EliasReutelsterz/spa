import 'package:flutter/material.dart';
import 'package:improsso/domain/general_domain/entities/course_entitiy.dart';
import 'package:improsso/domain/general_domain/entities/user_entity.dart';
import 'package:improsso/presentation/courses/buttons/add_selected_course_button.dart';

class GeneralUsecases {
  List<Widget> getListForAddCourses(
      UserEntity userEntity,
      Map<String, Map<String, dynamic>> courses,
      Map<String, CourseEntity> completedCourses) {
    for (String completedCourse in completedCourses.keys) {
      courses.remove(completedCourse);
    }
    List<Widget> list = [];
    for (String key in courses.keys) {
      list.add(AddSelectedCourseButton(
        course: courses[key]!,
        courseId: key,
      ));
    }
    return list;
  }
}
