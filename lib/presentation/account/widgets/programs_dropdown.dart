import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/application/user/observer_bloc/observer_bloc.dart';
import 'package:improsso/application/user/studies_bloc/studies_bloc.dart';

class ProgramsDropdown extends StatelessWidget {
  const ProgramsDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, observerState) {
        return BlocBuilder<StudiesBloc, StudiesState>(
          builder: (context, studiesState) {
            if (studiesState is StudiesSuccess &&
                observerState is ObserverSuccess) {
              return DropdownButtonFormField(
                  value: observerState.userEntity.currentProgramId,
                  decoration: const InputDecoration(labelText: "Program"),
                  items: studiesState.programs.keys
                      .map<DropdownMenuItem<String>>((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(studiesState.programs[key]!),
                    );
                  }).toList()
                    ..add(const DropdownMenuItem<String>(
                        value: "", child: Text(""))),
                  onChanged: (String? selectedValue) {
                    BlocProvider.of<ControllerBloc>(context).add(
                        UpdateCurrentProgramEvent(
                            context: context, input: selectedValue!));
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
