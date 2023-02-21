import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/completedCourses_bloc/completed_courses_bloc.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/application/user/observer_bloc/observer_bloc.dart';
import 'package:improsso/presentation/courses/buttons/delete_selected_course.dart';

class DeleteCourseButton extends StatelessWidget {
  const DeleteCourseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllerBloc controllerbloc = BlocProvider.of<ControllerBloc>(context);
    return BlocBuilder<CompletedCoursesBloc, CompletedCoursesState>(
      builder: (context, completedCoursesState) {
        return BlocBuilder<ObserverBloc, ObserverState>(
          builder: (context, observerState) {
            if (observerState is ObserverSuccess &&
                completedCoursesState is CompletedCoursesSuccess) {
              return TextButton(
                child: const Text("Delete Course"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (contex) => AlertDialog(
                              title: const Text("Delete course"),
                              content: Column(
                                children: observerState
                                        .userEntity.currentProgramId.isEmpty
                                    ? [
                                        const Text(
                                            "You havent selected your program yet")
                                      ]
                                    : completedCoursesState.courses.keys
                                        .map((key) {
                                        return DeleteSelectedCourseButton(
                                          completedCourseEntity:
                                              completedCoursesState
                                                  .courses[key]!,
                                          controllerBloc: controllerbloc,
                                        );
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
              return const Placeholder();
            }
          },
        );
      },
    );
  }
}
