import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/studies_bloc/studies_bloc.dart';

class UnisDropdown extends StatelessWidget {
  const UnisDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudiesBloc, StudiesState>(
      builder: (context, studiesState) {
        if (studiesState is StudiesSuccess) {
          return DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "University"),
              items: studiesState.universities.keys
                  .map<DropdownMenuItem<String>>((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(studiesState.universities[key]!),
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
