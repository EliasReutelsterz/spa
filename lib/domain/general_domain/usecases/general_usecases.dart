import 'package:improsso/domain/general_domain/entities/completed_course_entitiy.dart';
import 'package:improsso/domain/general_domain/entities/general_course_entity.dart';

class GeneralUsecases {
  Map<String, GeneralCourseEntity> getListForAddCourses(
    Map<String, GeneralCourseEntity> courses,
    Map<String, CompletedCourseEntity> completedCourses,
  ) {
    Map<String, GeneralCourseEntity> helperCourses = {};
    for (String generalCourseKey in courses.keys) {
      if (!completedCourses.containsKey(generalCourseKey)) {
        helperCourses[generalCourseKey] = courses[generalCourseKey]!;
      }
    }
    return helperCourses;
  }
}
