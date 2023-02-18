import 'package:flutter/material.dart';

class StudiesEntity {
  final Map<String, String> unisMap;
  final Map<String, String> programsMap;
  final Map<String, Map<String, dynamic>> courseMap;

  StudiesEntity(
      {required this.unisMap,
      required this.programsMap,
      required this.courseMap});
}
