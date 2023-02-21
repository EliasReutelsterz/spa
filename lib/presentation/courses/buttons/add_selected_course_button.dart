import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/core/data.dart';
import 'package:improsso/core/validators/add_course_validators.dart';
import 'package:improsso/domain/general_domain/entities/completed_course_entitiy.dart';
import 'package:improsso/domain/general_domain/entities/general_course_entity.dart';

class AddSelectedCourseButton extends StatelessWidget {
  final GeneralCourseEntity course;
  final String courseId;
  final ControllerBloc controllerBloc;
  AddSelectedCourseButton(
      {Key? key,
      required this.course,
      required this.courseId,
      required this.controllerBloc})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddCourseValidators formValidators = AddCourseValidators();
  final Data data = Data();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (contextDialog) => AlertDialog(
                      title: Text("Add ${course.name}"),
                      content: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: SizedBox(
                            height: 150,
                            width: 100,
                            child: ListView(
                                padding: const EdgeInsets.all(10),
                                children: [
                                  TextFormField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                        suffixIcon: Icon(Icons.grade),
                                        labelText: "Grade"),
                                    validator: formValidators.validate_grade,
                                  ),
                                  DropdownButtonFormField(
                                    items: data
                                        .getSemesterList()
                                        .map<DropdownMenuItem<String>>(
                                            (String semester) {
                                      return DropdownMenuItem<String>(
                                        value: semester,
                                        child: Text(semester),
                                      );
                                    }).toList(),
                                    onChanged: (dynamic input) {},
                                    value: "FSS 2023",
                                    decoration: const InputDecoration(
                                        labelText: "Semester"),
                                    validator: formValidators.validate_semester,
                                  )
                                ]),
                          )),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controllerBloc.add(AddCompletedCourseEvent(
                                    context: context,
                                    courseEntity: CompletedCourseEntity(
                                        uniId: course.uniId,
                                        programId: course.programId,
                                        name: course.name,
                                        grade: formValidators.grade,
                                        ects: course.ects,
                                        field: course.field,
                                        semester: formValidators.semester,
                                        id: courseId)));
                                return Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              }
                            },
                            child: const Text("Add")),
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel")),
                      ]));
        },
        child: Text(course.name));
  }
}
