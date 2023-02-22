import 'package:improsso/core/data.dart';
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

  Map<String, List<String>> getSemestersOfCompletedCourses(
      Map<String, CompletedCourseEntity> courses) {
    Map<String, List<String>> output = {};
    for (String key in courses.keys) {
      if (!output.containsKey(courses[key]!.semester)) {
        output[courses[key]!.semester] = [key];
      } else {
        output[courses[key]!.semester]!.add(key);
      }
    }
    Data data = Data();
    List<String> semesterList = data.getSemesterList();
    Map.fromEntries(output.entries.toList()
      ..sort((e1, e2) => semesterList
          .indexOf(e1.key)
          .compareTo(semesterList.indexOf(e2.key))));
    return output;
  }
}
