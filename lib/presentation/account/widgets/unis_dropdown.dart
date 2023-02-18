import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/application/user/observer_bloc/observer_bloc.dart';
import 'package:improsso/application/user/studies_bloc/studies_bloc.dart';

class UnisDropdown extends StatelessWidget {
  const UnisDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, observerState) {
        return BlocBuilder<StudiesBloc, StudiesState>(
          builder: (context, studiesState) {
            if (studiesState is StudiesSuccess &&
                observerState is ObserverSuccess) {
              return DropdownButtonFormField(
                  value: observerState.userEntity.currentUniversityId,
                  decoration: const InputDecoration(labelText: "University"),
                  items: studiesState.universities.keys
                      .map<DropdownMenuItem<String>>((String key) {
                    return DropdownMenuItem<String>(
                        value: key,
                        child: Text(studiesState.universities[key]!));
                  }).toList(),
                  onChanged: (String? selectedValue) {
                    BlocProvider.of<ControllerBloc>(context).add(
                        UpdateCurrentUniversityEvent(
                            context: context, input: selectedValue!));
                    BlocProvider.of<ControllerBloc>(context).add(
                        UpdateCurrentProgramEvent(context: context, input: ""));
                    BlocProvider.of<StudiesBloc>(context)
                        .add(LoadStudiesEvent());
                  });
            } else {
              return const Placeholder();
            }
          },
        );
      },
    );
  }
}
