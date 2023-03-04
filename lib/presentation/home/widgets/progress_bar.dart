import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/completedCourses_bloc/completed_courses_bloc.dart';
import 'package:improsso/application/user/observer_bloc/observer_bloc.dart';
import 'package:improsso/application/user/studies_bloc/studies_bloc.dart';
import 'package:improsso/domain/general_domain/usecases/general_usecases.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedCoursesBloc, CompletedCoursesState>(
      builder: (context, completedCoursesState) {
        return BlocBuilder<StudiesBloc, StudiesState>(
          builder: (context, studiesState) {
            return BlocBuilder<ObserverBloc, ObserverState>(
              builder: (context, observerState) {
                if (observerState is ObserverSuccess &&
                    studiesState is StudiesSuccess &&
                    completedCoursesState is CompletedCoursesSuccess) {
                  double sumDoneEcts =
                      GeneralUsecases.getSumEcts(completedCoursesState.courses);
                  int totalEcts = studiesState
                      .programs[observerState.userEntity.currentProgramId]!
                      .totalEcts;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                            "You're done with ${sumDoneEcts} out of ${totalEcts} ECTS"),
                        const SizedBox(height: 20),
                        LinearProgressIndicator(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary),
                          minHeight: 15,
                          value: sumDoneEcts / totalEcts,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
