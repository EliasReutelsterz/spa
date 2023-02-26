import 'package:improsso/core/data.dart';
import 'package:improsso/domain/general_domain/entities/completed_course_entitiy.dart';
import 'package:improsso/domain/general_domain/entities/general_course_entity.dart';
import 'package:improsso/domain/general_domain/entities/main_plot_data_point_entity.dart';
import 'package:improsso/domain/general_domain/entities/pie_chart_data_point_entity.dart';
import 'package:improsso/domain/general_domain/entities/user_entity.dart';

class GeneralUsecases {
  static Map<String, GeneralCourseEntity> getListForAddCourses(
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

  static Map<String, List<String>> getSemestersOfCompletedCourses(
      Map<String, CompletedCourseEntity> courses) {
    Map<String, List<String>> output = {};
    for (String key in courses.keys) {
      if (!output.containsKey(courses[key]!.semester)) {
        output[courses[key]!.semester] = [key];
      } else {
        output[courses[key]!.semester]!.add(key);
      }
    }
    List<String> semesterList = Data.semesters;
    output = Map.fromEntries(output.entries.toList()
      ..sort((e1, e2) => semesterList
          .indexOf(e1.key)
          .compareTo(semesterList.indexOf(e2.key))));
    return output;
  }

  static int getSumEcts(Map<String, CompletedCourseEntity> courses) {
    int sumEcts = 0;
    for (CompletedCourseEntity completedCourse in courses.values) {
      sumEcts += completedCourse.ects;
    }
    return sumEcts;
  }

  static List<MainPlotDataPointEntity> getEctsAndGradeDataAsLists(
      Map<String, CompletedCourseEntity> completedCourses) {
    List<MainPlotDataPointEntity> output = [];
    Map<String, List<CompletedCourseEntity>> semesterMap = {};
    for (CompletedCourseEntity completedCourse in completedCourses.values) {
      if (!semesterMap.containsKey(completedCourse.semester)) {
        semesterMap[completedCourse.semester] = [completedCourse];
      } else {
        semesterMap[completedCourse.semester]!.add(completedCourse);
      }
    }
    List<String> semesterList = Data.semesters;
    semesterMap = Map.fromEntries(semesterMap.entries.toList()
      ..sort((e1, e2) => semesterList
          .indexOf(e1.key)
          .compareTo(semesterList.indexOf(e2.key))));
    for (String key in semesterMap.keys) {
      int sumEctsPerSemester = 0;
      int sumEctsPerSemesterWithoutGraded = 0;
      double averageGrade = 0.0;
      for (CompletedCourseEntity completedCourse in semesterMap[key]!) {
        sumEctsPerSemester += completedCourse.ects;
        if (completedCourse.grade != null) {
          averageGrade += completedCourse.ects * completedCourse.grade!;
          sumEctsPerSemesterWithoutGraded += completedCourse.ects;
        }
      }
      output.add(MainPlotDataPointEntity(
          semester: key,
          ects: sumEctsPerSemester,
          averageGrade: double.parse(
              (averageGrade / sumEctsPerSemesterWithoutGraded)
                  .toStringAsFixed(1))));
    }
    return output;
  }

  static double getTotalAverageGrade(
      Map<String, CompletedCourseEntity> completedCourses) {
    double grade = 0.0;
    int sumEcts = 0;
    for (CompletedCourseEntity completedCourse in completedCourses.values) {
      if (completedCourse.graded) {
        grade += completedCourse.ects * completedCourse.grade!;
        sumEcts += completedCourse.ects;
      }
    }
    return double.parse((grade / sumEcts).toStringAsFixed(1));
  }

  static List<PieChartDataPointEntity> getPieChartDataList(
      Map<String, CompletedCourseEntity> completedCourses) {
    Map<String, int> fieldMap = {};
    List<PieChartDataPointEntity> outputList = [];
    for (CompletedCourseEntity completedCourse in completedCourses.values) {
      if (fieldMap.containsKey(completedCourse.field)) {
        fieldMap[completedCourse.field] =
            fieldMap[completedCourse.field]! + completedCourse.ects;
      } else {
        fieldMap[completedCourse.field] = completedCourse.ects;
      }
    }
    for (String field in fieldMap.keys) {
      outputList
          .add(PieChartDataPointEntity(field: field, ects: fieldMap[field]!));
    }
    return outputList;
  }
}
