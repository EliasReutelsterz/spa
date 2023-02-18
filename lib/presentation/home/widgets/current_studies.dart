import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
              return Text(
                  "Your current studies: ${studiesState.programs[observerState.userEntity.currentProgramId]} at ${studiesState.universities[observerState.userEntity.currentUniversityId]}");
            } else {
              return const Placeholder();
            }
          },
        );
      },
    );
  }
}
