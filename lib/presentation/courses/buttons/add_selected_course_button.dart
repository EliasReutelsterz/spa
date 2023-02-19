import 'package:flutter/material.dart';
import 'package:improsso/core/data.dart';
import 'package:improsso/core/validators/add_course_validators.dart';

class AddSelectedCourseButton extends StatefulWidget {
  final Map<String, dynamic> course;
  final String courseId;
  const AddSelectedCourseButton(
      {Key? key, required this.course, required this.courseId})
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
              builder: (contex) => AlertDialog(
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
                                    items:
                                        data.getSemesterListAsDropDownItems(),
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
                                //! hier print weg und Event triggern
                                print(
                                  formValidators.grade,
                                );
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
