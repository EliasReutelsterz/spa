import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/core/data.dart';
import 'package:improsso/core/validators/add_course_validators.dart';
import 'package:improsso/domain/general_domain/entities/course_entitiy.dart';

class AddSelectedCourseButton extends StatefulWidget {
  final Map<String, dynamic> course;
  final String courseId;
  final ControllerBloc controllerBloc;
  const AddSelectedCourseButton(
      {Key? key,
      required this.course,
      required this.courseId,
      required this.controllerBloc})
      : super(key: key);

  @override
  State<AddSelectedCourseButton> createState() =>
      _AddSelectedCourseButtonState();
}

class _AddSelectedCourseButtonState extends State<AddSelectedCourseButton> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddCourseValidators formValidators = AddCourseValidators();
  Data data = Data();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (contextDialog) => AlertDialog(
                      title: Text("Add ${widget.course['name']}"),
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
                                widget.controllerBloc.add(
                                    AddCompletedCourseEvent(
                                        context: context,
                                        courseEntity: CourseEntity(
                                            uniId: widget.course["uniId"],
                                            programId:
                                                widget.course["programId"],
                                            name: widget.course["name"],
                                            grade: formValidators.grade,
                                            ects: widget.course["ects"],
                                            field: widget.course["field"],
                                            semester: formValidators.semester,
                                            id: widget.courseId)));
                                return Navigator.pop(context);
                              }
                            },
                            child: const Text("Add")),
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel")),
                      ]));
        },
        child: Text(widget.course["name"]));
  }
}
