import 'package:flutter/material.dart';

class CourseEntity {
  final String uniId;
  final String programId;
  final String name;
  final double grade;
  final int ects;
  final String field;

  CourseEntity(
      {required this.uniId,
      required this.programId,
      required this.name,
      required this.grade,
      required this.ects,
      required this.field});
}
