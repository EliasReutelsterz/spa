import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/observer_bloc/observer_bloc.dart';
import 'package:improsso/application/user/studies_bloc/studies_bloc.dart';

class CurrentStudies extends StatelessWidget {
  const CurrentStudies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudiesBloc, StudiesState>(
      builder: (context, studiesState) {
        return BlocBuilder<ObserverBloc, ObserverState>(
          builder: (context, observerState) {
            if (studiesState is StudiesSuccess &&
                observerState is ObserverSuccess) {
              return Align(
                alignment: Alignment.center,
                child: Text(
                  "${studiesState.programs[observerState.userEntity.currentProgramId]!.name}\n at ${studiesState.universities[observerState.userEntity.currentUniversityId]!.name}",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
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
  }
}
