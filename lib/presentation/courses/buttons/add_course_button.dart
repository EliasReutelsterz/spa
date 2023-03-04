import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/completedCourses_bloc/completed_courses_bloc.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/application/user/observer_bloc/observer_bloc.dart';
import 'package:improsso/application/user/studies_bloc/studies_bloc.dart';
import 'package:improsso/domain/general_domain/entities/general_course_entity.dart';
import 'package:improsso/domain/general_domain/usecases/general_usecases.dart';
import 'package:improsso/presentation/courses/buttons/add_graded_selected_course_button.dart';
import 'package:improsso/presentation/courses/buttons/add_ungraded_selected_course_button.dart';

class AddCourseButton extends StatelessWidget {
  const AddCourseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllerBloc controllerbloc = BlocProvider.of<ControllerBloc>(context);
    return BlocBuilder<CompletedCoursesBloc, CompletedCoursesState>(
      builder: (context, completedCoursesState) {
        return BlocBuilder<StudiesBloc, StudiesState>(
          builder: (context, studiesState) {
            return BlocBuilder<ObserverBloc, ObserverState>(
              builder: (context, observerState) {
                if (studiesState is StudiesSuccess &&
                    observerState is ObserverSuccess &&
                    completedCoursesState is CompletedCoursesSuccess) {
                  Map<String, GeneralCourseEntity> cleanedList =
                      GeneralUsecases.getListForAddCourses(
                          studiesState.courses, completedCoursesState.courses);
                  return TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary),
                    child: Text("Add Course",
                        style: Theme.of(context).textTheme.headline1),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (contex) => AlertDialog(
                                  title: const Text("Add course"),
                                  content: Column(
                                    children: observerState
                                            .userEntity.currentProgramId.isEmpty
                                        ? [
                                            const Text(
                                                "You havent selected your program yet")
                                          ]
                                        : cleanedList.keys.map((key) {
                                            if (cleanedList[key]!.graded) {
                                              return AddGradedSelectedCourseButton(
                                                  course: cleanedList[key]!,
                                                  courseId: key,
                                                  controllerBloc:
                                                      controllerbloc);
                                            } else {
                                              return AddUnGradedSelectedCourseButton(
                                                  course: cleanedList[key]!,
                                                  courseId: key,
                                                  controllerBloc:
                                                      controllerbloc);
                                            }
                                          }).toList(),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Cancel")),
                                  ]));
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          },
        );
      },
    );
  }
}
