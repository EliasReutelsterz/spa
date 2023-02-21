import 'package:improsso/domain/general_domain/entities/general_course_entity.dart';
import 'package:improsso/domain/general_domain/entities/program_entity.dart';
import 'package:improsso/domain/general_domain/entities/uni_entity.dart';

class StudiesEntity {
  final Map<String, UniEntity> unisMap;
  final Map<String, ProgramEntity> programsMap;
  final Map<String, GeneralCourseEntity> courseMap;

  StudiesEntity(
      {required this.unisMap,
      required this.programsMap,
      required this.courseMap});
}
