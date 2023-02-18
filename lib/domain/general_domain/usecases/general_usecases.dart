import 'package:flutter/material.dart';
import 'package:improsso/domain/general_domain/entities/course_entitiy.dart';
import 'package:improsso/domain/general_domain/entities/user_entity.dart';

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
      list.add(
          TextButton(onPressed: () {}, child: Text(courses[key]!["name"])));
    }
    return list;
  }
}
