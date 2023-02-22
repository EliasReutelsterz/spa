import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/completedCourses_bloc/completed_courses_bloc.dart';
import 'package:improsso/domain/general_domain/usecases/general_usecases.dart';

class TableCompletedCourses extends StatelessWidget {
  const TableCompletedCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedCoursesBloc, CompletedCoursesState>(
      builder: (context, completedCoursesState) {
        if (completedCoursesState is CompletedCoursesSuccess) {
          GeneralUsecases generalUsecases = GeneralUsecases();
          Map<String, List<String>> semestersMap = generalUsecases
              .getSemestersOfCompletedCourses(completedCoursesState.courses);
          List<Widget> semesterWidgets = [];
          for (String semester in semestersMap.keys) {
            List<Widget> courseWidgets = [];
            for (String courseId in semestersMap[semester]!) {
              courseWidgets.add(Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(completedCoursesState.courses[courseId]!.name)
                  ],
                ),
              ));
            }
            semesterWidgets.add(
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).colorScheme.tertiary),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text("${semester}"),
                    const SizedBox(height: 10)
                  ]
                    ..addAll(courseWidgets)
                    ..add(const SizedBox(height: 10)),
                ),
              ),
            );
            semesterWidgets.add(const SizedBox(height: 20));
          }
          return Column(
            children: semesterWidgets,
          );
        } else {
          return const Placeholder();
        }
      },
    );
  }
}
