import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/completedCourses_bloc/completed_courses_bloc.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/application/user/observer_bloc/observer_bloc.dart';
import 'package:improsso/application/user/studies_bloc/studies_bloc.dart';
import 'package:improsso/domain/general_domain/usecases/general_usecases.dart';

class AddCourseButton extends StatelessWidget {
  const AddCourseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllerBloc controllerbloc = BlocProvider.of<ControllerBloc>(context);
    GeneralUsecases generalUsecases = GeneralUsecases();
    return BlocBuilder<CompletedCoursesBloc, CompletedCoursesState>(
      builder: (context, completedCoursesState) {
        return BlocBuilder<StudiesBloc, StudiesState>(
          builder: (context, studiesState) {
            return BlocBuilder<ObserverBloc, ObserverState>(
              builder: (context, observerState) {
                if (studiesState is StudiesSuccess &&
                    observerState is ObserverSuccess &&
                    completedCoursesState is CompletedCoursesSuccess) {
                  return TextButton(
                    child: const Text("Add Course"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (contex) => AlertDialog(
                                  title: const Text("Add course"),
                                  content: Column(
                                    children: studiesState.courses.isEmpty
                                        ? [
                                            const Text(
                                                "You havent selected your program yet")
                                          ]
                                        : generalUsecases.getListForAddCourses(
                                            observerState.userEntity,
                                            studiesState.courses,
                                            completedCoursesState.courses,
                                            controllerbloc),
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
      },
    );
  }
}
