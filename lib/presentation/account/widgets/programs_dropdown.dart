import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/studies_bloc/studies_bloc.dart';

class ProgramsDropdown extends StatelessWidget {
  const ProgramsDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudiesBloc, StudiesState>(
      builder: (context, studiesState) {
        if (studiesState is StudiesSuccess) {
          return DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Program"),
              items: studiesState.programs.keys
                  .map<DropdownMenuItem<String>>((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(studiesState.programs[key]!),
                );
              }).toList(),
              onChanged: (String? selectedValue) {
                print(selectedValue);
              });
        } else {
          return const Placeholder();
        }
      },
    );
  }
}
