import 'package:flutter/material.dart';

class CourseEntity {
  final String uniId;
  final String programId;
  final String name;
  final double grade;
  final int ects;
  final String field;
  final String semester;
  final String id;

  CourseEntity(
      {required this.uniId,
      required this.programId,
      required this.name,
      required this.grade,
      required this.ects,
      required this.field,
      required this.semester,
      required this.id});
}
